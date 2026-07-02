# ElFulk Mobile App

Flutter mobile app scaffold for ElFulk with feature-first modules, flavor-aware startup, and a dummy networking layer that keeps the app runnable while backend contracts are still evolving.

## Current stack

- dependency injection with `get_it`
- routing with `go_router`
- state management with `flutter_bloc`
- immutable states and union results with `freezed`
- request and response serialization with `json_serializable`
- networking with `dio`, `retrofit`, `ApiResult`, and `ApiErrorHandler`
- responsive sizing with `flutter_screenutil`
- shared helpers and utils under `lib/src/core/helpers/`
- development and production flavors
- native splash generation with `flutter_native_splash`
- launcher icon generation with `flutter_launcher_icons`

## Feature groups

- `lib/src/features/app_features/`
- `lib/src/features/parent_features/`
- `lib/src/features/child_features/`

Each feature follows the same baseline shape:

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
    widgets/          (only if the feature needs local reusable widgets)
```

Rules already applied in this repo:

- models are only `request_models`, `response_models`, or `view_models`
- UI consumes `view_models` only
- repositories normalize failures through `ApiResult`
- Cubit or Bloc maps `response_models` into `view_models` before state emission

## Creating a new feature

Use this workflow because it matches the current codebase:

1. Choose the correct group:
   - `app_features`
   - `parent_features`
   - `child_features`
2. Create the feature folder:

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

Add `request_models/` only if the feature has `POST`, `PATCH`, or similar writes.

3. Add models:
   - response models use `@JsonSerializable(createToJson: false)`
   - request models use `@JsonSerializable(createFactory: false)`
   - view models are plain UI-facing models built from response models
4. Extend the group-level networking files, not a per-feature service:
   - `app_features` -> `lib/src/core/networking/app/`
   - `parent_features` -> `lib/src/core/networking/parent/`
   - `child_features` -> `lib/src/core/networking/child/`
5. Add endpoint constants in the matching `*_api_constants.dart`
6. Add Retrofit methods in the matching `*_api_service.dart`
7. Add dummy responses in `lib/src/core/networking/helper/dummy_api_interceptor.dart` so the feature stays runnable offline
8. Add the repository and return `ApiResult<ResponseModel>`
9. Add Cubit or Bloc and map `response_models` into `view_models`
10. Register the repository and logic in `lib/src/core/config/di/dependency_injection.dart`
11. If the feature is navigable, add route constants and route wiring in:
    - `lib/src/core/config/routing/routes.dart`
    - `lib/src/core/config/routing/app_router.dart`
12. If the route should appear in the Dev Hub catalog, add a `RouteCatalogItem` to `Routes.catalog` in `routes.dart`
13. Run:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
```

Current feature references to copy from:

- simple GET + Cubit: `app_features/home`
- GET/POST/PATCH + Bloc: `parent_features/parent_requests`

## Current example modules

- `app_features/home`: Cubit + GET example
- `app_features/architecture`: architecture reference screen
- `app_features/dev_hub`: development-only route catalog and theme switcher
- `parent_features/parent_home`: Cubit + GET example
- `parent_features/parent_requests`: Bloc + GET/POST/PATCH example
- `child_features/child_home`: Cubit + GET example

## Project structure

- app boot: `lib/src/app/boot/boot_app.dart`
- app shell: `lib/src/core/app/elfulk_app.dart`
- dependency injection: `lib/src/core/config/di/dependency_injection.dart`
- routing: `lib/src/core/config/routing/app_router.dart`
- helpers and utils: `lib/src/core/helpers/helpers.dart`
- networking: `lib/src/core/networking/`
- shared theme and widgets: `lib/src/core/theme/`, `lib/src/core/widgets/`

## Running the app

Install dependencies:

```bash
flutter pub get
```

Generate code after changing Freezed, Retrofit, or JsonSerializable files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Run development flavor:

```bash
flutter run --flavor development -t lib/main_development.dart
```

Current production status:

- `lib/main_production.dart` is present
- production Firebase files are still template/local-only setup
- production should be treated as incomplete until real Firebase config is wired locally

## VS Code tasks

The repo includes tasks in `.vscode/tasks.json` for:

- `Flutter: Pub Get`
- `Flutter: Build Runner`
- `Flutter: Analyze`
- `Flutter: Test`
- run/build tasks for both flavors
- splash generation tasks
- launcher icon generation tasks

## Firebase config

Development Firebase config is committed.
Production Firebase config is local-only and should not be committed.

Relevant files:

- development: `lib/src/core/config/firebase/firebase_options_development.dart`
- production template: `lib/src/core/config/firebase/firebase_options_production.example.dart`
- production local target: `lib/src/core/config/firebase/firebase_options_production.dart`

See `docs/firebase-open-source.md` for the exact setup flow.

## Launcher icons

Launcher icons use separate config files per flavor:

- `flutter_launcher_icons-development.yaml`
- `flutter_launcher_icons-production.yaml`

Generate them with:

```bash
dart run flutter_launcher_icons -f flutter_launcher_icons-development.yaml
dart run flutter_launcher_icons -f flutter_launcher_icons-production.yaml
```

Source assets currently in the repo:

- `assets/images/development_launcher_icon.png`
- `assets/images/development_launcher_icon_foreground.png`
- `assets/images/production_launcher_icon.png`
- `assets/images/production_launcher_icon_foreground.png`

The current launcher icon assets are placeholders copied from the splash images.
