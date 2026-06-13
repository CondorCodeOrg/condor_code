---
sidebar_position: 3
title: FVM (Flutter Version Manager)
---

# FVM — Flutter Version Manager

The CondorCode monorepo uses **FVM** (Flutter Version Manager) to ensure everyone uses the same Flutter version. This avoids "works on my machine" issues and matches CI/CD, which runs Flutter 3.35.0.

## Why FVM?

- **Consistent versions** — All team members use the same Flutter/Dart version.
- **Project isolation** — Different projects can use different Flutter versions.
- **CI parity** — Local builds match what runs in GitHub Actions.

## Prerequisites

Install Flutter SDK globally first (FVM uses it internally). Then install FVM.

## Installation

### macOS / Linux

**Install script (recommended):**
```bash
curl -fsSL https://fvm.app/install.sh | bash
```

**Homebrew:**
```bash
brew tap leoafarias/fvm
brew install fvm
```

**Dart pub:**
```bash
dart pub global activate fvm
```

### Windows

```bash
choco install fvm
```

Or via Dart: `dart pub global activate fvm`

### Configure PATH

Add FVM to your PATH so the `fvm` command works. The install script prints instructions. For manual setup:

- **Zsh (macOS):** Add `export PATH="$HOME/fvm/bin:$PATH"` to `~/.zshrc`
- **Bash:** Add the same line to `~/.bashrc`

Restart your terminal or run `source ~/.zshrc` (or `~/.bashrc`).

## Project Setup

The CondorCode workspace uses **Flutter 3.35.0** (see root `pubspec.yaml`).

From the **workspace root**:

```bash
fvm use 3.35.0
```

This:

- Installs Flutter 3.35.0 if needed
- Creates a `.fvm` directory (gitignored) and config (e.g. `.fvmrc` or `fvm_config.json`)
- Sets this version for the project

## Running Commands with FVM

Use `fvm` before `dart` or `flutter` so the project’s Flutter version is used:

| Task | Command |
|------|---------|
| Melos bootstrap | `fvm dart run melos bootstrap` |
| Melos commands | `fvm dart run melos run analyze` (or format, generate, etc.) |
| Flutter run | `fvm flutter run` |
| Flutter build | `fvm flutter build web` |

From the workspace root:

```bash
fvm dart run melos bootstrap
fvm dart run melos run generate
```

From an app directory:

```bash
cd apps/condor_code_app
fvm flutter run
```

## Common Commands

| Command | Description |
|---------|-------------|
| `fvm list` | List installed Flutter versions |
| `fvm install 3.35.0` | Install a specific Flutter version |
| `fvm use 3.35.0` | Set the Flutter version for the current project |
| `fvm releases` | List available Flutter releases |
| `fvm flutter --version` | Check the active Flutter version |

## IDE / Editor Setup

### VS Code / Cursor

1. Install the **Flutter** extension.
2. Run `fvm use 3.35.0` in the project root.
3. Run **Flutter: Change SDK** (or similar) and choose the FVM path, e.g. `.fvm/flutter_sdk`.
4. Or set `dart.flutterSdkPath` to `.fvm/flutter_sdk` in `.vscode/settings.json`.

### Android Studio

1. Run `fvm use 3.35.0` in the project root.
2. In **Languages & Frameworks → Flutter**, set the Flutter SDK path to `<project>/.fvm/flutter_sdk`.

## Troubleshooting

| Issue | Fix |
|-------|-----|
| `fvm: command not found` | Add FVM to PATH and restart the terminal |
| Wrong Flutter version used | Run `fvm use 3.35.0` in the workspace root |
| `.fvm` or `.fvmrc` conflicts | `.fvm/` is gitignored. Commit `.fvmrc` or `fvm_config.json` if your team pins the version there |
| Old cache / odd behavior | Run `fvm flutter clean` in the app, then `fvm dart run melos bootstrap` |

## Related

- [Working with the Monorepo](working-with-monorepo.md) — Setup and Melos commands
- [CI/CD](../ci-cd.md) — How CI uses Flutter 3.35.0

**FVM documentation:** [fvm.app](https://fvm.app)
