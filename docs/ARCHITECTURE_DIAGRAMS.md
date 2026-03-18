# ElFulk Architecture Diagrams

ElFulk currently uses a feature-first Flutter structure with GetIt dependency injection, GoRouter navigation, Bloc/Cubit state management, ScreenUtil-based responsive sizing, and Retrofit networking over a shared Dio client. The backend layer is currently satisfied by a dummy Dio interceptor so the app stays runnable without a live server.

## 1) Startup and DI

```mermaid
flowchart TD
    A[main_development.dart or main_production.dart] --> B[bootApp]
    B --> C[ScreenUtil.ensureScreenSize]
    C --> D[Firebase.initializeApp]
    D --> E[AppEnvironment.fromFlavor]
    E --> F[setupGetIt]
    F --> G[configureApiBaseUrl]
    F --> H[DioFactory.getDio]
    F --> I[register ApiServices Repositories Cubits and Blocs]
    I --> J[runApp ElFulkApp]
    J --> K[ScreenUtilInit]
```

## 2) Routing and feature groups

```mermaid
flowchart TD
    R[GoRouter] --> A[app_features home]
    R --> P[parent_features parent_home]
    R --> PR[parent_features parent_requests]
    R --> C[child_features child_home]
    R --> X[app_features architecture]

    A --> BA[BlocProvider HomeCubit]
    P --> BP[BlocProvider ParentHomeCubit]
    PR --> BR[BlocProvider ParentRequestsBloc]
    C --> BC[BlocProvider ChildHomeCubit]
    X --> BX[BlocProvider ArchitectureCubit]
```

## 3) Networking flow

```mermaid
flowchart LR
    UI[Screen] --> LOGIC[Cubit or Bloc]
    LOGIC --> REPO[Repository]
    REPO --> API[Retrofit ApiService]
    API --> DIO[DioFactory]
    DIO --> DUMMY[DummyApiInterceptor]
    DUMMY --> API
    API --> REPO
    REPO --> RESULT[ApiResult]
    RESULT --> LOGIC
    LOGIC --> VIEW[View model]
    VIEW --> UI
```

## 4) Folder structure

```text
lib/
  main_development.dart
  main_production.dart
  src/
    app/
      boot/
        boot_app.dart
    core/
      app/
        elfulk_app.dart
      config/
        app_environment.dart
        di/
        routing/
        firebase/
      helpers/
        helpers.dart
        src/
          utils/
      networking/
        app/
        parent/
        child/
        error/
        helper/
      theme/
        app_theme.dart
      widgets/
        app_section_card.dart
    features/
      app_features/
        home/
        architecture/
      parent_features/
        parent_home/
        parent_requests/
      child_features/
        child_home/
```
