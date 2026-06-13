# Onboarding

Welcome to CondorCode! This guide is a **step-by-step walkthrough** for anyone joining the project. Follow the steps in order. Each step tells you exactly what to do and how to verify it.

> 🆕 **What if I just want to browse the app?**  
> Jump to [How to Visit the App](#how-to-visit-the-app) if you only want to see it running.

---

## What You Are Building

CondorCode is a **gamified learning platform** — like Duolingo for programming. Learners follow roadmaps, solve quizzes and coding challenges, earn rewards, and communicate with other learners.

The repository contains **two Flutter apps** and **shared packages**:

| App / Package | What it does |
|---------------|--------------|
| `apps/condor_code_app` | The **main student app** — lessons, quizzes, progress, rewards |
| `apps/condor_code_admin_app` | The **admin dashboard** — course creation, content management |
| `packages/data` | Shared data layer — repositories, API clients, Firebase wrappers |
| `packages/domain` | Shared business logic — entities, use cases |
| `packages/ui_kit` | Shared UI components and theme |
| `packages/logger` | Shared logging utilities |

Both apps share the same backend (Firebase) and are built from a **single entry point** (`lib/main.dart`) configured at runtime with `--dart-define` flags.

---

## How to Visit the App

You can try CondorCode without writing any code:

| Environment | URL | What to expect |
|-------------|-----|----------------|
| **Production** | *(URL will be added here)* | Live app with real data |
| **Staging** | *(URL will be added here)* | Latest `develop` branch, for QA |

---

## How the App Works Locally

When you run the app on your machine you choose **two things** at launch:

1. **Build type** — which Firebase project to use
   - `dev` (default) — local development
   - `staging` — pre-production
   - `prod` — production

2. **Data source** — where the data comes from
   - `mock` (default) — fake local data, no Firebase account needed
   - `remote` — real Firebase data

| Combination | Command | When to use |
|-------------|---------|-------------|
| **Dev + Mock** (default) | `fvm flutter run` | First-time setup, UI work, no internet |
| Dev + Remote | `fvm flutter run --dart-define=BUILD_TYPE=dev --dart-define=DATA_SOURCE=remote` | Testing real data, integration work |
| Prod + Remote | `fvm flutter run --dart-define=BUILD_TYPE=prod --dart-define=DATA_SOURCE=remote` | Testing production behaviour locally |

> 💡 **Start with `mock` data.** It requires zero Firebase setup and the app works offline.

---

## Step 1: Before You Start

Make sure you have:
- **Flutter SDK** installed globally (any version — we pin it later with FVM)
- **Git** access to the repository
- A **terminal** open at the project root

---

## Step 2: Clone the Repository

```bash
# If you haven't cloned yet:
git clone https://github.com/CondorCodeOrg/condor_code_monorepo.git
cd condor_code_monorepo
```

**Check:** You see folders `apps/`, `packages/`, `wiki/`, and files `pubspec.yaml`, `melos.yaml`.

---

## Step 3: Install and Set Up FVM

We pin Flutter to **3.35.0** so everyone (and CI) uses the exact same version.

1. [Install FVM](https://fvm.app) if you haven't already:
   ```bash
   dart pub global activate fvm
   ```
2. From the project root:
   ```bash
   fvm use 3.35.0
   ```
3. Confirm:
   ```bash
   fvm flutter --version
   # Should print 3.35.0
   ```

**Check:** `fvm` command works and reports version 3.35.0.

---

## Step 4: Understand the Workspace

Read [**Working with the Monorepo**](../codebase/conventions/working-with-monorepo.md). It explains:
- How `apps/` and `packages/` relate
- When to run `melos bootstrap` and `melos run generate`
- Where to put new code
- Common beginner mistakes

**Check:** You know the difference between an "app" and a "package", and you know to run Melos commands from the project root.

---

## Step 5: Bootstrap the Monorepo

Install dependencies and link packages across the workspace.

From the **project root**:
```bash
fvm dart run melos bootstrap
```

**Check:** Command finishes with no errors.

---

## Step 6: Run Code Generation

We auto-generate files (e.g. `*.g.dart`, `*.freezed.dart`) from annotations. Never edit generated files by hand.

```bash
fvm dart run melos run generate
```

**Check:** Command completes. You may see a lock warning — that's normal, just wait.

---

## Step 7: Analyze the Codebase

Run static analysis to catch issues early:

```bash
fvm dart run melos run analyze
```

**Check:** No errors. If you see issues, ask the team before continuing.

---

## Step 8: Run the App for the First Time

Pick an app and run it in the easiest mode (dev + mock, no Firebase needed).

**Main student app:**
```bash
cd apps/condor_code_app
fvm flutter run
```

**Admin dashboard:**
```bash
cd apps/condor_code_admin_app
fvm flutter run
```

For web: add `-d chrome` to either command.

**Check:** The app launches. Tap through a few screens to confirm it works.

---

## Step 9: Set Up Firebase (Optional)

> 💡 **You only need this if you want to use `remote` data.**
> The `mock` mode works offline with zero Firebase setup.

For full instructions — including how to create your own Firebase project, register Android and iOS apps, and generate Dart options — see the dedicated guide:

- [🔥 Firebase Setup](firebase-setup.md)

Quick check: after setup you should be able to run either app with:
```bash
fvm flutter run --dart-define=BUILD_TYPE=dev --dart-define=DATA_SOURCE=remote
```

---

## Step 10: Learn the Conventions

Before you write your first feature, read these short guides:

- [**Architectural Conventions**](../codebase/conventions/arch_conventions.md) — Clean Architecture, Bloc, where logic lives
- [**Git Conventions**](../codebase/version_control/git_conventions.md) — Commit format `type(scope): description`
- [**UI Conventions**](../codebase/conventions/ui_conventions.md) — Design tokens, widgets, theming

**Check:** You can write a commit like `feat(cc-app): add lesson progress card` and you know which layer of the architecture your code belongs in.

---

## Your First Contribution

Now that everything runs:

1. Pick an issue labeled `good first issue` or ask the team for a starter task.
2. Create a branch from `develop`:
   ```bash
   git checkout develop
   git pull upstream develop
   git checkout -b feature/your-task-name
   ```
3. Write your code following the conventions above.
4. Run pre-push checks:
   ```bash
   fvm dart run melos run prepush
   ```
   This runs **generate → format → analyze**, exactly like CI.
5. Push and open a Pull Request to `develop`.

For full contribution rules (code of conduct, commit format, PR template), see [**CONTRIBUTING.md**](https://github.com/CondorCodeOrg/condor_code_monorepo/blob/main/CONTRIBUTING.md).

---

## Quick Reference

| I want to... | Command |
|--------------|---------|
| Install deps after cloning | `fvm dart run melos bootstrap` |
| Regenerate code after model changes | `fvm dart run melos run generate` |
| Check code quality | `fvm dart run melos run analyze` |
| Format everything | `fvm dart run melos run format` |
| Run before every push | `fvm dart run melos run prepush` |
| Run main app (mock, easiest) | `cd apps/condor_code_app && fvm flutter run` |
| Run admin app (mock, easiest) | `cd apps/condor_code_admin_app && fvm flutter run` |

---

## Need Help?

| Question | Where to look |
|----------|---------------|
| How does the monorepo work? | [Working with the Monorepo](../codebase/conventions/working-with-monorepo.md) |
| How do I set up FVM? | [FVM](../codebase/conventions/fvm.md) |
| What does CI/CD do? | [CI/CD](../codebase/ci-cd.md) |
| How do I contribute? | [CONTRIBUTING.md](https://github.com/CondorCodeOrg/condor_code_monorepo/blob/main/CONTRIBUTING.md) |
| How is the code organised? | [Architectural Conventions](../codebase/conventions/arch_conventions.md) |

