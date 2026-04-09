## 2.0.0

- **BREAKING**: Bump minimum SDK to Dart >=3.11.0, Flutter >=3.41.0
- **BREAKING**: Bump iOS deployment target to 13.0, macOS to 10.15
- Upgrade Pigeon from v9 to v26 and regenerate all bindings
- `requestPermission()` on iOS is now properly async — waits for permission dialog result
- Remove obsolete `#available(iOS 10.0, *)` and `#available(OSX 10.14, *)` checks
- Bump Swift version to 5.9
- Remove unnecessary i386 architecture exclusion
- Add unit tests

## 1.0.4+dev

- [iOS] Migrate from the deprecated badge API (#3).
  Now `getBadgeCount` in iOS isn't recommended because it depends on the deprecated API and could be unavailable in future iOS releases.

## 1.0.4 - 5th May 2024

- [iOS] added privacy manifest
- Bump `flutter` version to 3.19.6
- Add `derry` to manage scripts
- Update dependencies and increase version

## 1.0.3 - 18th April 2023

- Update dep

## 1.0.2 - 18th April 2023

- Fix typo on readme

## 1.0.1 - 15th April 2023

- Downgrade to dart 2.18.4 and flutter 3.0.0

## 1.0.0 - 15th April 2023

- Initial open source release of flutter_native_badge_foundation
