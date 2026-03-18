# AI Agent Context Playbook (ElFulk)

Purpose: this file gives an AI agent enough current context to work safely in this repository without relying on stale migration notes.

## 1) Repository map

Workspace root contains:

- `lib/`: Flutter app source
- `docs/`: engineering documentation
- `test/`: automated tests
- `.vscode/tasks.json`: common project tasks
- `flutter_launcher_icons-*.yaml`: launcher icon config
- `flutter_native_splash-*.yaml`: splash config

Core app paths:

- `lib/main_development.dart`
- `lib/main_production.dart`
- `lib/src/app/boot/boot_app.dart`
- `lib/src/core/app/elfulk_app.dart`
- `lib/src/core/config/di/dependency_injection.dart`
- `lib/src/core/config/routing/routes.dart`
- `lib/src/core/config/routing/app_router.dart`
- `lib/src/core/helpers/helpers.dart`
- `lib/src/core/networking/`
- `lib/src/features/`

## 2) Current app baseline

This repo is currently a scaffolded ElFulk baseline, not a fully built product yet.

The implemented sample areas are:

- `app_features/home`
- `app_features/architecture`
- `parent_features/parent_home`
- `parent_features/parent_requests`
- `child_features/child_home`

These examples are intentionally small but they define the patterns the project should follow.

## 3) Architecture rules in this repo

The app uses a feature-first layered structure.

Each feature should stay inside:

```text
lib/src/features/<group>/<feature>/
  data/
    request_models/   (only if the feature writes data)
    response_models/
    view_models/
    repos/
  logic/
    cubit/ or bloc/
  ui/
    screens/
    widgets/          (optional)
```

Non-negotiable rules already established:

- UI works with `view_models` only
- feature models are limited to `request_models`, `response_models`, or `view_models`
- repositories own API calls and error normalization
- Cubit or Bloc maps `response_models` into `view_models`
- shared code belongs in `lib/src/core/`
- generic helpers belong in `lib/src/core/helpers/`

## 4) State management

Packages in use:

- `flutter_bloc`
- `freezed`

Current usage:

- Cubit is the default for linear flows
- Bloc is used when a flow coordinates multiple events or write operations

Current examples:

- Cubit: `HomeCubit`, `ParentHomeCubit`, `ChildHomeCubit`, `ArchitectureCubit`
- Bloc: `ParentRequestsBloc`

## 5) Routing

Routing is centralized in `lib/src/core/config/routing/app_router.dart` using `GoRouter`.

Current routes:

- `/`
- `/parent`
- `/parent/requests`
- `/child`
- `/architecture`

Route-level `BlocProvider` creation is the current convention.

## 6) Dependency injection

DI is centralized in `setupGetIt()`.

Current registrations include:

- `AppEnvironment`
- shared `Dio`
- feature API services
- repositories
- Cubit and Bloc factories

Do not instantiate repositories or API services directly inside UI code.

## 7) Networking

Networking stack:

- `DioFactory`
- Retrofit API services
- repositories
- `ApiResult`
- `ApiErrorHandler`
- `DummyApiInterceptor`

Important current behavior:

- one flavor-level base URL is resolved through `devBaseUrl` or `prodBaseUrl`
- dummy responses are served through the Dio interceptor so the app remains runnable without a backend
- write examples already exist for `POST` and `PATCH` in `parent_features/parent_requests`
- API services are grouped by feature group, not by individual feature
- new feature endpoints are currently added to one of:
  - `lib/src/core/networking/app/app_api_service.dart`
  - `lib/src/core/networking/parent/parent_api_service.dart`
  - `lib/src/core/networking/child/child_api_service.dart`

## 8) Helpers and utilities

Shared helpers live in `lib/src/core/helpers/`.

Current helper coverage:

- spacing helpers
- validators
- regex and input formatters
- date, duration, and number formatters
- URL helpers and URL launcher wrappers
- shared preferences and secure storage helpers
- simple app constants and localization helpers

Prefer using these helpers before introducing feature-local utility duplication.

## 9) Startup and flavors

Startup flow:

1. `WidgetsFlutterBinding.ensureInitialized()`
2. preserve native splash
3. `ScreenUtil.ensureScreenSize()`
4. `Firebase.initializeApp(...)`
5. resolve `AppEnvironment`
6. call `setupGetIt(environment)`
7. `runApp(const ElFulkApp())`

Flavor entrypoints:

- development: `lib/main_development.dart`
- production: `lib/main_production.dart`

Current status:

- development is the normal runnable flavor
- production still depends on local Firebase wiring

## 10) UI conventions

- `ScreenUtilInit` is applied once in the app shell
- use `.w`, `.h`, `.r`, and `.sp` in widgets where responsive sizing is appropriate
- keep rendering in `BlocBuilder`
- keep side effects in `BlocListener` or `BlocConsumer`
- move shared reusable widgets into `lib/src/core/widgets/` only after actual repetition appears

## 11) Common commands

Install dependencies:

```bash
flutter pub get
```

Generate code:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Analyze:

```bash
flutter analyze
```

Test:

```bash
flutter test
```

Run development flavor:

```bash
flutter run --flavor development -t lib/main_development.dart
```

## 12) Feature checklist for future work

When adding a new feature:

1. choose the correct group: `app_features`, `parent_features`, or `child_features`
2. create the folder baseline:

```text
lib/src/features/<group>/<feature>/
  data/
    response_models/
    view_models/
    repos/
  logic/
    cubit/ or bloc/
  ui/
    screens/
```

3. add `request_models/` only if the feature has write operations
4. create response models with `@JsonSerializable(createToJson: false)`
5. create request models with `@JsonSerializable(createFactory: false)`
6. create view models that the UI will consume
7. extend the matching group API constants and group API service
8. add or extend dummy responses in `DummyApiInterceptor`
9. add repository methods that return `ApiResult<ResponseModel>`
10. add Cubit or Bloc that maps `response_models` into `view_models`
11. register repository and logic in `setupGetIt()`
12. add route wiring in `routes.dart` and `app_router.dart` if the feature is navigable
13. keep UI bound to view models only
14. run build runner, analyze, and tests

Current examples to copy from:

- `app_features/home`: GET + Cubit + route
- `parent_features/parent_requests`: GET + POST + PATCH + Bloc + request models
