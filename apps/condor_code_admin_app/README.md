# condorcode_admin

## Build Flavors & Launch Modes

The app uses a single entry point (`lib/main.dart`) and is configured via `--dart-define` flags at runtime.

### Build Type (`BUILD_TYPE`)

| Flavor | Command |
|--------|---------|
| **Dev** (default) | `fvm flutter run` |
| Staging | `fvm flutter run --dart-define=BUILD_TYPE=staging` |
| Production | `fvm flutter run --dart-define=BUILD_TYPE=prod` |

### Data Source (`DATA_SOURCE`)

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