# CondorCode

CondorCode is a cross-platform application designed with a Clan Architecture, leveraging a modern
tech stack for scalability, maintainability, and high performance.

## Build Flavors & Launch Modes

The app uses a single entry point (`lib/main.dart`) and is configured via `--dart-define` flags at runtime.

### Build Type (`BUILD_TYPE`)

Controls the environment and Firebase project selection.

| Flavor | Command |
|--------|---------|
| **Dev** (default) | `fvm flutter run` |
| Staging | `fvm flutter run --dart-define=BUILD_TYPE=staging` |
| Production | `fvm flutter run --dart-define=BUILD_TYPE=prod` |

### Data Source (`DATA_SOURCE`)

Controls whether the app uses local mock data or connects to Firebase.

| Source | Command |
|--------|---------|
| **Mock** (default) | `fvm flutter run` |
| Remote (Firebase) | `fvm flutter run --dart-define=DATA_SOURCE=remote` |

### Combined Examples

| Mode | Command |
|------|---------|
| **Dev + mock** (default, no Firebase needed) | `fvm flutter run` |
| Dev + remote | `fvm flutter run --dart-define=BUILD_TYPE=dev --dart-define=DATA_SOURCE=remote` |
| Staging + remote | `fvm flutter run --dart-define=BUILD_TYPE=staging --dart-define=DATA_SOURCE=remote` |
| Production + remote | `fvm flutter run --dart-define=BUILD_TYPE=prod --dart-define=DATA_SOURCE=remote` |

> **Default:** `BUILD_TYPE=dev`, `DATA_SOURCE=mock`. Running `fvm flutter run` with no flags starts the app in dev mock mode — no Firebase setup required.

### Web

```bash
fvm flutter run -d chrome --dart-define=BUILD_TYPE=dev --dart-define=DATA_SOURCE=mock
```

### Production Build

```bash
fvm flutter build web -t lib/main.dart --release --dart-define=BUILD_TYPE=prod --dart-define=DATA_SOURCE=remote
```

## Architecture

The project follows a **Clean Architecture**:

- **Presentation Layer**: Flutter UI, organized by screens and widgets. Each screen is split into
  subcomponents and uses Bloc for state management.
- **State Management**: **Bloc pattern ensures predictable state transitions and separation of
  concerns.**  
  👉 _See_ `lib/ui/screens/lesson/bloc` _for an implementation example._
- **Domain Layer**: Contains business logic, models, and use cases. Entities and repositories
  abstractions are defined here.
- **Data Layer**: Handles data access via repositories implementations and data sources managers (
  local/remote) and mapps it.

## Architectural Approach

- **Feature-first**: Code is grouped by feature (e.g., lesson, profile), improving modularity and
  scalability.
- **Bloc Pattern**: Each feature has its own Bloc, Event, and State classes, ensuring clear state
  management.
- **Dependency Injection**: Uses GetIt for DI, enabling easy testing and swapping of
  implementations.
- **Separation of Concerns**: UI, business logic, and data access are strictly separated.

## SDD Documentation

The Software Design Documentation (SDD) is maintained in the `wiki/` directory, built with
Docusaurus. It serves as the single source of truth for architecture decisions, implementation
guidelines, team conventions, onboarding and maintenance knowledge. The md. files with docs
information stored in `wiki/docs/` and its subfolders.

> [!]
> **Ask the wiki pin code from codeowners to access the wiki and contribute to the documentation.**

To run the local documentation server, navigate to the `wiki/` directory and execute:

```bash
cd wiki
npm start
```

To see the production version of the documentation, visit:
https://condorcode-docs.web.app

## Flutter Web + Firebase Hosting

This app is configured for path-based web routing (without `#` in URLs).
For correct deep-link behavior on Firebase Hosting, all routes must rewrite to `index.html`.
The rewrite rule is already configured in `firebase.json`.

Build and deploy production web:

```bash
fvm flutter build web -t lib/main.dart --release --dart-define=BUILD_TYPE=prod --dart-define=DATA_SOURCE=remote
firebase deploy --only hosting --project YOUR_PROD_PROJECT_ID
```