# Bloc/Cubit Architecture

This document describes the current state-management architecture used in ElFulk.

## 1) Current style

The app uses a feature-first layered structure with a hybrid Cubit and Bloc approach.

- `Cubit` is the default for straightforward load and update flows
- `Bloc` is used for event-heavy flows or write coordination
- `freezed` is used for typed state unions and event unions
- repositories sit between logic and Retrofit API services

## 2) Feature grouping

Current feature groups are:

- `app_features`
- `parent_features`
- `child_features`

Each feature should follow:

```text
lib/src/features/<group>/<feature>/
  data/
    request_models/   (only if writes exist)
    response_models/
    view_models/
    repos/
  logic/
    cubit/ or bloc/
  ui/
    screens/
    widgets/          (optional)
```

## 3) Current examples in this repo

Cubit examples:

- `app_features/onboarding` (local page state + SharedPreferences completion flag)
- `app_features/home`
- `app_features/architecture`
- `parent_features/parent_home`
- `child_features/child_home`

Bloc example:

- `parent_features/parent_requests`

`parent_requests` is the current reference when a feature needs:

- initial GET loading
- POST creation
- PATCH updates
- transient feedback after mutations

## 4) State-management rules

- UI consumes `view_models` only
- request and response models stay out of the UI layer
- repositories return `ApiResult<T>`
- logic maps `response_models` into `view_models`
- loading, loaded, and error states should be explicit
- side effects belong in listeners, not in build logic

## 5) Dependency injection and route scope

DI is centralized in:

- `lib/src/core/config/di/dependency_injection.dart`

Routing is centralized in:

- `lib/src/core/config/routing/app_router.dart`

Current convention:

- API services: lazy singletons
- repositories: lazy singletons
- Cubits and Blocs: factories
- logic is provided at route level with `BlocProvider`
- API services are grouped by feature group:
  - `app_api_service.dart`
  - `parent_api_service.dart`
  - `child_api_service.dart`

## 6) Data flow

The standard flow is:

1. UI triggers Cubit method or Bloc event
2. logic emits loading or transition state
3. repository calls Retrofit API service
4. repository returns `ApiResult.success` or `ApiResult.failure`
5. logic emits loaded, error, or feedback state
6. UI rebuilds or reacts in a listener

## 7) When to choose Cubit

Use Cubit when:

- the feature mostly loads data and updates local state directly
- there are only a few commands like `loadOverview()`, `refresh()`, or `retry()`
- there is no complex event sequencing
- the feature holds local UI state such as page index or completion flags

## 8) When to choose Bloc

Use Bloc when:

- the feature has multiple user intents with different transitions
- GET and write operations coexist in the same screen
- transient mutation feedback must be managed explicitly
- the event stream is easier to reason about than imperative Cubit methods

## 9) Implementation checklist

When adding a new Cubit or Bloc:

1. add response models first
2. add request models only if the feature writes data
3. add view models for UI consumption
4. extend the matching group API constants and group Retrofit API service
5. extend `DummyApiInterceptor` so the feature works without a live backend
6. add or extend the repository and return `ApiResult<ResponseModel>`
7. implement Cubit or Bloc and map `response_models` into `view_models`
8. register the logic class in `setupGetIt()`
9. wire the route in `app_router.dart` if the feature is navigable
10. keep UI bound to `view_models` only
11. run build runner, analyze, and tests
