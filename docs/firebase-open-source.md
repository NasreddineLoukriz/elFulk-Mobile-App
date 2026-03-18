# Firebase Setup for Public Repository

This repository keeps development Firebase configuration in version control and treats production Firebase configuration as local-only or CI-only setup.

## Committed files

Development Firebase configuration is committed:

- `android/app/src/development/google-services.json`
- `ios/config/development/GoogleService-Info.plist`
- `lib/src/core/config/firebase/firebase_options_development.dart`

## Local-only files

Production Firebase configuration must not be committed:

- `android/app/src/production/google-services.json`
- `ios/config/production/GoogleService-Info.plist`
- `lib/src/core/config/firebase/firebase_options_production.dart`

## Templates included in the repo

Reference templates are committed so production setup is discoverable:

- `android/app/src/production/google-services.example.json`
- `ios/config/production/GoogleService-Info.example.plist`
- `lib/src/core/config/firebase/firebase_options_production.example.dart`

## Development setup

Install dependencies:

```bash
flutter pub get
```

Run development flavor:

```bash
flutter run --flavor development -t lib/main_development.dart
```

## Production local setup

Generate production Firebase files locally:

```bash
flutterfire configure \
  --project=<PROD_FIREBASE_PROJECT_ID> \
  --platforms=android,ios \
  --android-package-name=com.elfulk \
  --ios-bundle-id=com.elfulk \
  --out=lib/src/core/config/firebase/firebase_options_production.dart \
  --android-out=android/app/src/production/google-services.json \
  --ios-out=ios/config/production/GoogleService-Info.plist \
  --yes
```

Current note:

- `lib/main_production.dart` still points at the example Firebase options file in the committed baseline
- switch it to the real local production file before treating production as fully runnable

## Safe commit check

Before pushing, confirm production Firebase files are not staged:

```bash
git status --short
```
