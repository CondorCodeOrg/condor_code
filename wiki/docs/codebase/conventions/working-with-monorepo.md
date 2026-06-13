---
sidebar_position: 1
title: Working with the Monorepo
---

# Working with the Monorepo

This guide helps newcomers understand how to work with the **condor_code**. Read this
before starting development.

Our repository GitHub link: [condor_code](https://github.com/CondorCodeOrg/condor_code)

## Workspace Structure

The monorepo contains two main parts:

- **Apps** — Flutter applications that end users run
- **Packages** — Shared code used by multiple apps

| Path                         | Description                                             |
|------------------------------|---------------------------------------------------------|
| `apps/condor_code_app`       | Main CondorCode mobile/web app                          |
| `apps/condor_code_admin_app` | Admin dashboard app                                     |
| `packages/data`              | Data layer: repositories, API clients, models, Firebase |
| `packages/domain`            | Domain layer: entities, repository abstractions         |
| `packages/logger`            | Shared logging utilities                                |
| `packages/ui_kit`            | Shared UI components and theme                          |

Apps depend on packages via path dependencies in `pubspec.yaml`.

For how **admin** and **main** apps share **course/lesson** data in Firestore (including **lesson order**), see [Admin app, main app, and shared content](../admin-main-app-content-sync.md).

---

## Prerequisites

- **Flutter 3.35.0** (see root `pubspec.yaml` for the exact version)
- **Dart 3.9+**
- **FVM** (Flutter Version Manager) — recommended for consistent Flutter versions. See [FVM](fvm.md)
  for installation and setup.

---

## First-Time Setup

1. Clone the repository and open a terminal at the **workspace root** (the folder containing
   `pubspec.yaml`, `melos`, and `wiki`).

2. Bootstrap the workspace (installs dependencies and links packages):
   ```bash
   fvm dart run melos bootstrap
   ```

3. Run code generation (see [Code Generation](#code-generation) below):
   ```bash
   fvm dart run melos run generate
   ```

4. Verify everything works:
   ```bash
   fvm dart run melos run analyze
   ```

If `analyze` passes, you are ready to run the apps.

---

## Running Apps

From the workspace root:

**Main app:**

```bash
cd apps/condor_code_app
fvm flutter run
```

**Admin app:**

```bash
cd apps/condor_code_admin_app
fvm flutter run
```

You can specify a target, for example: `fvm flutter run -d chrome` for web, or
`fvm flutter run -d <device_id>` for a specific device.

### Launch Modes

Both apps use a single entry point (`lib/main.dart`) and are configured via `--dart-define`:

| Variable | Values | Default | Description |
|----------|--------|---------|-------------|
| `BUILD_TYPE` | `dev`, `staging`, `prod` | `dev` | Environment / Firebase project |
| `DATA_SOURCE` | `mock`, `remote` | `mock` | Local mock data vs Firebase |

**Default (no Firebase needed):**
```bash
fvm flutter run
```

**With Firebase:**
```bash
fvm flutter run --dart-define=BUILD_TYPE=dev --dart-define=DATA_SOURCE=remote
```

See each app's README for the full list of launch combinations.

---

## Melos Commands

Always run Melos commands from the **workspace root**. Use `fvm dart run melos` if your project uses
FVM.

| Command              | When to use                                                                                     |
|----------------------|-------------------------------------------------------------------------------------------------|
| `melos bootstrap`    | After cloning, after pulling changes that add/update packages, or when dependencies seem broken |
| `melos run analyze`  | Check code quality and lint issues                                                              |
| `melos run format`   | Format all Dart code                                                                            |
| `melos run fix`      | Auto-fix linter warnings where possible                                                         |
| `melos run generate` | After changing models, freezed classes, or other generated code                                 |
| `melos run prepush`  | **Before pushing** — runs generate + format + analyze (mirrors CI)                              |
| `melos run verify`   | Run analyze + format (quick sanity check)                                                       |
| `melos run clean`    | Clean build dirs; run `melos bootstrap` afterward                                               |
| `melos run test`     | Run tests across all packages                                                                   |

See the root `README.md` in the repository for the full list of Melos commands.

[!] "'ERROR: ERROR: ERROR: [data]: Waiting for another flutter command to release the startup
lock...'" is
normal because some commands (like `generate`) run `flutter pub run build_runner` under the hood,
which uses a lock file to prevent concurrent Flutter commands. Just wait for it to finish and the
lock will be released.

---

## Code Generation

Some code is **generated** from annotations (e.g. `json_serializable`, `freezed`). Generated files
end in:

- `*.g.dart`
- `*.freezed.dart`
- `*.gr.dart`

**Rules:**

1. **Never edit generated files by hand** — your changes will be overwritten.
2. **Run generation after changing source models** — add/change fields in `.dart` files, then run
   `melos run generate`.
3. **Always run `melos run generate` before pushing** — CI runs `check-generate` and will fail if
   generated files are out of date.

---

## Pre-Push Workflow

Before pushing or creating a PR, run:

```bash
fvm dart run melos run prepush
```

This runs **generate** → **format** → **analyze** in sequence, matching what CI checks. If `prepush`
passes locally, CI should pass too.

Or run the steps manually: `melos run generate`, `melos run format`, `melos run analyze`.

See [CI/CD](../ci-cd.md) for full pipeline details.

---

## Where to Add Code

- **App-specific UI or logic** → `apps/condor_code_app` or `apps/condor_code_admin_app`
- **Shared data access, API, models** → `packages/data`
- **Shared business entities and abstractions** → `packages/domain`
- **Shared UI components** → `packages/ui_kit`
- **Shared logging** → `packages/logger`

To add a new dependency to a package, edit its `pubspec.yaml`. Use `path:` for local packages, e.g.
`domain: path: ../domain`. Then run `melos bootstrap`.

---

## Common Pitfalls

| Pitfall                                             | What happens                             | Fix                                                       |
|-----------------------------------------------------|------------------------------------------|-----------------------------------------------------------|
| Forgetting to run `generate`                        | CI `check-generate` fails                | Run `melos run prepush` before pushing                    |
| Running commands from inside `apps/` or `packages/` | Melos may not work as expected           | Run Melos from workspace root                             |
| Editing `*.g.dart` or `*.freezed.dart`              | Changes are overwritten on next generate | Edit the source `.dart` file and run `melos run generate` |
| Not bootstrapping after pull                        | Broken or outdated package links         | Run `melos bootstrap` after pulling                       |
| Wrong Flutter version                               | Build or runtime errors                  | Use FVM and `fvm use` to match project Flutter version    |

---

## Next Steps

- [FVM](fvm.md) — Flutter Version Manager setup and usage
- [CI/CD](../ci-cd.md) — GitHub Actions pipelines and workflow details
- [Architectural Conventions](./arch_conventions.md) — Clean Architecture, Bloc, DI
- [Navigation Conventions](./navigation_conventions.md) — GoRouter, browser history, Back/Forward, YouTube + routes
- [Git Conventions](../version_control/git_conventions.md) — Commit message format and scopes
- [UI Conventions](./ui_conventions.md) — UI and design guidelines
