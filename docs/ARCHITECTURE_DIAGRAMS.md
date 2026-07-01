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
    F --> T[register ThemeCubit]
    I --> J[runApp ElFulkApp]
    T --> J
    J --> K[ScreenUtilInit]
    K --> L[BlocProvider ThemeCubit]
    L --> M[MaterialApp.router theme darkTheme themeMode]
```

## 2) Routing and feature groups

```mermaid
flowchart TD
    R[GoRouter] --> O[app_features onboarding]
    R --> A[app_features auth]
    R --> H[app_features home]
    R --> P[parent_features parent_home]
    R --> PR[parent_features parent_requests]
    R --> C[child_features child_home]
    R --> X[app_features architecture]

    O --> BO[BlocProvider OnboardingCubit]
    A --> BA[login register otp forget_password screens]
    H --> BH[BlocProvider HomeCubit]
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
      constants/
        app_breakpoint.dart
        app_raduis.dart
        app_spacing.dart
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
        app_colors.dart
        app_theme.dart
        logic/
          cubit/
            theme_cubit.dart
            theme_state.dart
      widgets/
        app_screen_template.dart
        app_section_card.dart
        custom_text_field.dart
        divider_with_text.dart
        footer_text.dart
        primary_button.dart
        social_button.dart
        theme_toggle_button.dart
    features/
      app_features/
        onboarding/
        auth/
        home/
        architecture/
      parent_features/
        parent_home/
        parent_requests/
      child_features/
        child_home/
```
