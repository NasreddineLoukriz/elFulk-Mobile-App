# Cubit/Bloc Quick Reference

Short practical reference for adding state logic in ElFulk.

## 1) Choose Cubit or Bloc

Use `Cubit` when:

- the screen has a small number of command-style actions
- one repository call maps directly to one state update
- the feature is mostly load, refresh, retry, or simple local state changes
- the feature holds local UI state such as page index or completion flags

Use `Bloc` when:

- the screen coordinates multiple event types
- GET and write operations happen together
- mutation feedback needs to be cleared independently of full reloads

Current Cubit examples:

- `app_features/onboarding` (page index, completion flag)
- `core/theme` (theme mode persistence)
- `app_features/home`
- `app_features/architecture`
- `parent_features/parent_home`
- `child_features/child_home`

Current Bloc example:

- `parent_features/parent_requests`

## 2) Placement

Put logic under:

- `lib/src/features/<group>/<feature>/logic/cubit/`
- `lib/src/features/<group>/<feature>/logic/bloc/`

Allowed groups in this repo:

- `app_features`
- `parent_features`
- `child_features`

## 3) Model boundaries

Use only:

- `request_models`
- `response_models`
- `view_models`

Rule:

- UI works with `view_models` only

## 4) Repository and API flow

Expected flow:

1. API service returns `response_models`
2. repository normalizes result into `ApiResult`
3. Cubit or Bloc maps to `view_models`
4. UI renders state

Current repo detail:

- add endpoints to the group-level API service for the feature group
- update `DummyApiInterceptor` for the same endpoints if the feature should stay runnable offline

## 5) DI checklist

Update `lib/src/core/config/di/dependency_injection.dart`:

1. extend the existing group API service if needed
2. register repository as lazy singleton
3. register Cubit or Bloc as factory

## 6) Routing checklist

Update:

- `lib/src/core/config/routing/routes.dart`
- `lib/src/core/config/routing/app_router.dart`

Current convention:

- provide Cubit or Bloc at route level

## 7) Error handling

Repositories should:

- wrap API calls with `try/catch`
- map failures through `ApiErrorHandler.handle(error)`
- return `ApiResult.failure(...)`

Logic should:

- emit explicit error states
- keep user feedback or navigation side effects in listener-friendly states when needed

## 8) Minimal Cubit skeleton

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:elfulk/src/core/networking/helper/api_result.dart';
import 'package:elfulk/src/features/app_features/example/data/repos/example_repository.dart';
import 'package:elfulk/src/features/app_features/example/data/response_models/example_overview_response_model.dart';
import 'package:elfulk/src/features/app_features/example/data/view_models/example_view_model.dart';
import 'package:elfulk/src/core/networking/error/api_error_model.dart';

part 'example_cubit.freezed.dart';
part 'example_state.dart';

class ExampleCubit extends Cubit<ExampleState> {
  ExampleCubit(this._repository) : super(const ExampleState.initial());

  final ExampleRepository _repository;

  Future<void> loadData() async {
    emit(const ExampleState.loading());

    final ApiResult<ExampleOverviewResponseModel> result =
        await _repository.getData();
    result.when(
      success: (ExampleOverviewResponseModel data) => emit(
        ExampleState.loaded(ExampleViewModel.fromResponseModel(data)),
      ),
      failure: (ApiErrorModel error) => emit(ExampleState.error(error)),
    );
  }
}
```

## 9) Build and test commands

```bash
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
```

## 10) Minimal feature workflow

1. create `response_models`, `view_models`, and `repos`
2. add `request_models` only if writes exist
3. extend the matching group API constants and API service
4. update `DummyApiInterceptor`
5. register the repository and Cubit or Bloc in DI
6. route the screen if needed
