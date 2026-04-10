## 2.0.1 - 10th April 2026

- Add comprehensive dartdoc to all public APIs
- Add `analysis_options.yaml` with `flutter_lints`
- Add `topics` and `screenshots` to pubspec.yaml
- Rewrite README with platform support table, installation guide, migration guide from `flutter_app_badger`, and full API reference
- Fix example widget test

## 2.0.0 - 9th April 2026

- **BREAKING**: Bump minimum SDK to Dart >=3.11.0, Flutter >=3.41.0
- **BREAKING**: `isSupported` is now a synchronous getter instead of `Future<bool>`
- Deprecate `getBadgeCount()` — on iOS it uses a deprecated API (`applicationIconBadgeNumber`)
- Add standalone `requestPermission()` method
- Use `defaultTargetPlatform` instead of `dart:io` for platform checks (web-compatible)
- Remove leaked `checkPlatformAndRequestPermission` top-level function
- Upgrade Pigeon to v26 for regenerated native bindings
- Add unit tests

## 1.0.5+dev

- [iOS] Migrate from the deprecated badge API (#3).
  Now `getBadgeCount` in iOS isn't recommended because it depends on the deprecated API and could be unavailable in future iOS releases.

## 1.0.5 - 5th May 2024

- [iOS] added privacy manifest
- Bump `flutter` version to 3.19.6
- Add `derry` to manage scripts
- Update dependencies and increase version

## 1.0.4 - 18th April 2023

- Update dependencies and increase version

## 1.0.3 - 18th April 2023

- Add preview gif to readme

## 1.0.2 - 15th April 2023

- Update dependencies and increase version

## 1.0.1 - 15th April 2023

- Downgrade to dart 2.18.4

## 1.0.0 - 15th April 2023

- Initial Open source release of flutter_native_badge for iOS and macOS
