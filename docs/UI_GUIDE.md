# UI Guide - ElFulk

Practical UI conventions for the current ElFulk app structure.

## 1) Feature groups

The app is split into:

- `app_features`
- `parent_features`
- `child_features`

Each feature keeps:

- `data/`
- `logic/`
- `ui/`

Typical optional folders:

- `data/request_models/` only when the feature writes data
- `ui/widgets/` only when the feature has local reusable widgets

Sizing rule:

- initialize `ScreenUtilInit` once at the app shell
- use `.w`, `.h`, `.r`, and `.sp` for UI dimensions and font sizes

## 2) State and UI contract

Use `BlocBuilder`, `BlocListener`, or `BlocConsumer`.

Rules:

- rendering stays in builders
- side effects stay in listeners when needed
- repositories and services stay out of widgets
- widgets and screens consume view models only
- request models and response models stay out of the UI layer
- avoid hard-coded pixel dimensions in widgets when a ScreenUtil unit is appropriate
- prefer `lib/src/core/helpers/helpers.dart` for shared spacing, validators, extensions, and formatting instead of duplicating utility code inside features

## 3) Networking contract

Use the same pattern for all features:

- Retrofit `ApiService` for endpoint calls
- JsonSerializable request models, response models, or view models only
- `Repository` for error normalization and `ApiResult`
- `Cubit` or `Bloc` maps response models into view models before state emission
- `Screen` for rendering

## 4) Current example features

- `app_features/home`
- `parent_features/parent_home`
- `parent_features/parent_requests`
- `child_features/child_home`
- `app_features/architecture`

## 5) Build runner

Run after changing Freezed, Retrofit, or JsonSerializable files:

```bash
dart run build_runner build --delete-conflicting-outputs
```
