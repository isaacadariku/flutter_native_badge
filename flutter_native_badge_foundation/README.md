# flutter_native_badge_foundation

[![pub package](https://img.shields.io/pub/v/flutter_native_badge_foundation.svg)](https://pub.dev/packages/flutter_native_badge_foundation)

The iOS and macOS implementation of [`flutter_native_badge`](https://pub.dev/packages/flutter_native_badge).

## Usage

This package is [endorsed](https://flutter.dev/to/endorsed-federated-plugin), which means you can simply use `flutter_native_badge` normally. This package will be automatically included in your app when you do, so you do not need to add it to your `pubspec.yaml`.

However, if you import this package to use any of its APIs directly, you should add it to your `pubspec.yaml` as usual.

## Implementation Details

- Uses [Pigeon](https://pub.dev/packages/pigeon) for type-safe communication between Dart and native code
- iOS: Uses `UNUserNotificationCenter` for modern badge APIs (iOS 16+) with `applicationIconBadgeNumber` fallback
- macOS: Uses `NSApplication.dockTile.badgeLabel` for badge counts and `NSDockTile` for red dot indicators
- Includes `PrivacyInfo.xcprivacy` for Apple's privacy manifest requirements
