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

## 2) Design tokens, theming, and responsive sizing

### Spacing and radius tokens

The app uses a small design-token layer in `lib/src/core/constants/`:

- `AppBreakpoints`: `mobile = 600`, `tablet = 1024`
- `AppSpacing`: responsive spacing values that switch between mobile and tablet breakpoints
- `AppRadius`: semantic radius tokens (`xs`, `sm`, `md`, `lg`, `xl`, `xxl`, ...)

Access them through `BuildContext` extensions in `lib/src/core/helpers/src/utils/extension/`:

```dart
context.spacing.md   // responsive spacing
context.radius.lg    // radius token
```

### Theming

The app supports light and dark modes:

- `lib/src/core/theme/app_colors.dart` defines semantic color tokens for both brightness values
- `lib/src/core/theme/app_theme.dart` exposes `buildLightTheme()` and `buildDarkTheme()`
- `ThemeCubit` loads and persists the user's choice (`light` / `dark` / `system`) in `SharedPreferences`
- `ElFulkApp` supplies `theme`, `darkTheme`, and `themeMode` to `MaterialApp.router`
- `ThemeToggleButton` cycles through light → dark → system

Rules:

- do not hard-code `Color(0xFF…)` or `Colors.white` / `Colors.black` in widgets
- read colors from `Theme.of(context).colorScheme` or text styles from `Theme.of(context).textTheme`
- use `AppColors` directly only for colors that do not map cleanly to `ColorScheme`
- when opacity is needed, use `.withValues(alpha: …)` (not the deprecated `.withOpacity`)

Existing sizing rules:

- initialize `ScreenUtilInit` once at the app shell
- use `.w`, `.h`, `.r`, and `.sp` for UI dimensions and font sizes
- prefer design tokens over hard-coded values for spacing and radius

## 3) Shared core widgets

Reusable widgets live in `lib/src/core/widgets/`. Use them for auth, onboarding, and future form flows:

- `AppScreenTemplate`: RTL scaffold with top logo area, rounded white bottom sheet, and keyboard-aware layout
- `PrimaryButton`: full-width elevated button with optional icon and RTL icon flipping
- `CustomTextField`: text field with SVG prefix icon, optional password toggle, and error border coloring
- `SocialButton`: outlined button for social login icons
- `DividerWithText`: horizontal divider with centered label
- `FooterText`: question/action link row with optional countdown timer (used for resend OTP)

Guideline:

- extract a widget to `lib/src/core/widgets/` only after it is reused across features
- keep feature-specific variants inside the feature's `ui/widgets/`

## 4) State and UI contract

Use `BlocBuilder`, `BlocListener`, or `BlocConsumer`.

Rules:

- rendering stays in builders
- side effects stay in listeners when needed
- repositories and services stay out of widgets
- widgets and screens consume view models only
- request models and response models stay out of the UI layer
- avoid hard-coded pixel dimensions in widgets when a ScreenUtil unit or design token is appropriate
- prefer `lib/src/core/helpers/helpers.dart` for shared spacing, validators, extensions, and formatting instead of duplicating utility code inside features

## 5) Networking contract

Use the same pattern for all features:

- Retrofit `ApiService` for endpoint calls
- JsonSerializable request models, response models, or view models only
- `Repository` for error normalization and `ApiResult`
- `Cubit` or `Bloc` maps response models into view models before state emission
- `Screen` for rendering

## 6) Current example features

- `app_features/onboarding`
- `app_features/auth` (login, register, forget password, OTP verification)
- `app_features/home`
- `app_features/dev_hub`
- `parent_features/parent_home`
- `parent_features/parent_requests`
- `child_features/child_home`
- `app_features/architecture`

## 7) Dev Hub (UI development catalog)

The `app_features/dev_hub` screen is a development-only route catalog.

What it does:

- Lists every route registered in `Routes.catalog`
- Groups items by category (`screen`, `dialog`, `bottomSheet`)
- Tapping a route pushes it so you can preview the UI in isolation
- Has a theme-mode menu (light / dark / system) in the app bar for quick UI testing

Behavior:

- In **development**, the app starts at `/dev-hub`
- In **production**, `/dev-hub` redirects to `/onboarding`
- A "Dev Hub" floating action button is shown on the Home screen in development

How to add a new route to the catalog:

1. Add the route constant and `GoRoute` wiring as usual in:
   - `lib/src/core/config/routing/routes.dart`
   - `lib/src/core/config/routing/app_router.dart`
2. Append a `RouteCatalogItem` to `Routes.catalog` in `routes.dart`:

```dart
const RouteCatalogItem(
  path: Routes.myNewScreen,
  label: 'My New Screen',
  category: RouteCategory.screen,
  description: 'Optional helpful description',
  queryParameters: <String, String>{'tab': 'default'}, // optional
),
```

The Dev Hub will render the new item automatically.

## 8) Build runner

Run after changing Freezed, Retrofit, or JsonSerializable files:

```bash
dart run build_runner build --delete-conflicting-outputs
```
