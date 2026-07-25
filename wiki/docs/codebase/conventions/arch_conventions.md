# Architectural Conventions

The project follows a **Clean Architecture**:

- **Presentation Layer**: Flutter UI, organized by screens and widgets. Each screen is split into subcomponents and uses Bloc for state management.
- **State Management**: **Bloc pattern ensures predictable state transitions and separation of concerns.**  
  👉 _See_ `lib/ui/screens/lesson/bloc` _for an implementation example._
- **Domain Layer**: Contains business logic, models, and use cases. Entities and repositories abstractions are defined here.
- **Data Layer**: Handles data access via repositories implementations and data sources managers (local/remote) and mapps it.

### Architectural Approach

- **Feature-first**: Code is grouped by feature (e.g., lesson, profile), improving modularity and scalability.
- **Bloc Pattern**: Each feature has its own Bloc, Event, and State classes, ensuring clear state management.
- **Dependency Injection**: Uses GetIt for DI, enabling easy testing and swapping of implementations.
- **Separation of Concerns**: UI, business logic, and data access are strictly separated.

## Dependency Injection (DI)

Both apps use **GetIt** for service location and dependency injection.

### ProviderManager

Each app has a `ProviderManager` (`lib/di/provider_manager.dart`) that configures all dependencies at startup:

```dart
final providerManager = ProviderManager();
providerManager.configureDependencies(config);
```

### AppConfig

`AppConfig` is created from `--dart-define` environment variables and drives DI registration:

| Dart-define | Values | Default |
|-------------|--------|---------|
| `BUILD_TYPE` | `dev`, `staging`, `prod` | `dev` |
| `DATA_SOURCE` | `mock`, `remote` | `mock` |

### Mock Mode vs Remote Mode

The `DataSource` enum controls whether the app uses **local mock data** or **live Firebase data**:

- **Mock mode** (`DATA_SOURCE=mock`):
  - Registers `MockRemoteDataManager` instead of `RemoteDataManagerImpl`
  - Skips Firebase initialization entirely
  - Analytics uses `MockAnalyticsImpl` (no-op)
  - Perfect for offline development and UI testing

- **Remote mode** (`DATA_SOURCE=remote`):
  - Initializes Firebase with environment-specific options (`dev` / `staging` / `prod`)
  - Registers `RemoteDataManagerImpl` backed by Firebase Auth + Firestore
  - Analytics:
    - `dev` → `MockAnalyticsImpl`
    - `staging` → `FirebaseAnalyticsImpl`
    - `prod` → `FirebaseAnalyticsImpl`

### DI Registration Flow

1. `main.dart` reads `--dart-define` values and builds `AppConfig`
2. If `dataSource == remote`, Firebase is initialized with the correct `FirebaseOptions`
3. `ProviderManager.configureDependencies(config)` is called:
   - Registers `AppConfig` as a singleton
   - Registers analytics implementation based on config
   - Calls `data.DataModule.init(di, dataSource)` which registers either mock or real `RemoteDataManager`
   - Registers all repositories (they receive `RemoteDataManager` via DI)
   - Registers providers and blocs/cubits

### State Management per App

| App | State Management |
|---|---|
| `condor_code_app` (main) | **Bloc / Cubit** + GetIt |
| `admin_app` | **Riverpod** |

The `admin_app` uses **Riverpod** for state management instead of Bloc/Cubit. Follow Riverpod conventions and providers when working in the admin codebase.

### Data Access Rule

- **Widgets and screens must never access repositories directly.**
- All data flows through a `Cubit` or `Bloc` in the Presentation layer.
- Repositories are injected into state managers, not into UI components.
- This enforces unidirectional data flow and keeps UI code testable and presentation-focused.

### Repository Access in State Management

**Bloc/Cubit (condor_code_app) and Riverpod (admin_app) must never access data sources directly.**

- Always use repositories as the single source of truth for data access
- Repositories abstract the underlying data source (Firebase, mock, cache)
- This allows swapping implementations without changing business logic
- Enables consistent error handling and data transformation across the app

**Example:**
```dart
// ✅ CORRECT: Cubit uses repository
class CourseCubit extends Cubit<CourseState> {
  final LessonsRepository _lessonsRepository;  // Injected
  
  Future<void> loadLessons() async {
    final result = await _lessonsRepository.getLessonsItems(courseId);
    // ...
  }
}

// ❌ WRONG: Direct data source access
class CourseCubit extends Cubit<CourseState> {
  final FirebaseFirestore _firestore;  // Don't do this
  
  Future<void> loadLessons() async {
    final snapshot = await _firestore.collection('lessons').get();
    // ...
  }
}
```

### State Management per App

| App | State Management |
|---|---|
| `condor_code_app` (main) | **Bloc / Cubit** + GetIt |
| `admin_app` | **Riverpod** |

The `admin_app` uses **Riverpod** for state management instead of Bloc/Cubit. Follow Riverpod conventions and providers when working in the admin codebase.
