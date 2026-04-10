# flutter_native_badge

[![pub package](https://img.shields.io/pub/v/flutter_native_badge.svg)](https://pub.dev/packages/flutter_native_badge)
[![pub points](https://img.shields.io/pub/points/flutter_native_badge)](https://pub.dev/packages/flutter_native_badge/score)
[![likes](https://img.shields.io/pub/likes/flutter_native_badge)](https://pub.dev/packages/flutter_native_badge)
[![popularity](https://img.shields.io/pub/popularity/flutter_native_badge)](https://pub.dev/packages/flutter_native_badge)

A Flutter plugin that wraps native badge APIs on iOS and macOS. Set badge counts, show a red dot indicator, clear badges, and manage notification permissions — all through a simple Dart API.

## Features

- **Set badge count** — Display a numeric badge on your app icon
- **Show red dot** — Show a dot indicator without a number (macOS dock)
- **Clear badge** — Remove the badge from your app icon
- **Get badge count** — Read the current badge value (iOS only, deprecated API)
- **Request permission** — Handle iOS notification permission prompts
- **Platform check** — Safely check if the current platform supports badges

## Platform Support

| Feature               |      iOS      |   macOS    |
| --------------------- | :-----------: | :--------: |
| `setBadgeCount()`     |      ✅       |     ✅     |
| `clearBadgeCount()`   |      ✅       |     ✅     |
| `showRedDot()`        |      ✅       |     ✅     |
| `getBadgeCount()`     | ⚠️ Deprecated |     ✅     |
| `requestPermission()` |      ✅       | ✅ (no-op) |

> **Android support** is planned for a future release.

## Preview

<table width="100%">
  <thead>
    <tr>
      <th width="50%">iOS</th>
      <th width="50%">macOS</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td width="50%"><img src="https://user-images.githubusercontent.com/46024202/232333138-4b44a8d0-3121-434f-a863-2e74c8078d38.gif"/></td>
      <td width="50%"><img src="https://user-images.githubusercontent.com/46024202/232332734-430e8296-ce3b-4a86-a25b-5c30c3738b7c.gif"/></td>
    </tr>
  </tbody>
</table>

## Installation

Add `flutter_native_badge` to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_native_badge: ^2.0.0
```

Then run:

```sh
flutter pub get
```

## Quick Start

```dart
import 'package:flutter_native_badge/flutter_native_badge.dart';

// Check platform support first
if (FlutterNativeBadge.isSupported) {
  // Request permission (shows dialog on iOS)
  await FlutterNativeBadge.requestPermission();

  // Set badge count
  await FlutterNativeBadge.setBadgeCount(5);

  // Clear badge
  await FlutterNativeBadge.clearBadgeCount();
}
```

## API Reference

### Check if the platform is supported

```dart
bool isSupported = FlutterNativeBadge.isSupported;
```

Returns `true` on iOS and macOS, `false` on all other platforms. Use this before calling any other method to avoid `UnsupportedError`.

### Set badge count

```dart
await FlutterNativeBadge.setBadgeCount(5);
```

On iOS 16+, uses the modern `UNUserNotificationCenter.setBadgeCount` API. On earlier iOS versions, falls back to `applicationIconBadgeNumber`.

### Show red dot

```dart
await FlutterNativeBadge.showRedDot();
```

Shows a red dot indicator on the app icon without displaying a number. Useful for indicating new content.

### Clear badge count

```dart
await FlutterNativeBadge.clearBadgeCount();
```

Removes the badge from the app icon and resets the count to 0.

### Get badge count

```dart
int badgeCount = await FlutterNativeBadge.getBadgeCount();
```

> **⚠️ Deprecated on iOS:** This uses the `applicationIconBadgeNumber` API which Apple has deprecated. There is no replacement in the iOS SDK. Consider managing the count yourself via your backend or local storage.

### Request permission

```dart
await FlutterNativeBadge.requestPermission();
```

On iOS, presents the system notification permission dialog. On macOS, this is a no-op.

You can also pass `requestPermission: true` to any method to request permission inline:

```dart
await FlutterNativeBadge.setBadgeCount(5, requestPermission: true);
await FlutterNativeBadge.showRedDot(requestPermission: true);
await FlutterNativeBadge.clearBadgeCount(requestPermission: true);
```

## Permissions

### iOS

Badge counts on iOS require notification permissions. Call `requestPermission()` before setting a badge, or pass `requestPermission: true` to individual methods.

Add the following to your `Info.plist` if you haven't already configured push notifications:

```xml
<key>UIBackgroundModes</key>
<array>
    <string>remote-notification</string>
</array>
```

### macOS

No special permissions are required. Badge APIs work out of the box on macOS.

## Migrating from flutter_app_badger

[`flutter_app_badger`](https://pub.dev/packages/flutter_app_badger) has been **discontinued**. Here's how to migrate:

```dart
// Before (flutter_app_badger)
FlutterAppBadger.updateBadgeCount(5);
FlutterAppBadger.removeBadge();
FlutterAppBadger.isAppBadgeSupported();

// After (flutter_native_badge)
await FlutterNativeBadge.setBadgeCount(5);
await FlutterNativeBadge.clearBadgeCount();
FlutterNativeBadge.isSupported; // synchronous getter
```

**Key differences:**

- `flutter_native_badge` uses a federated plugin architecture for better maintainability
- Built-in permission handling with `requestPermission` parameter
- `showRedDot()` for dot-only indicators on macOS
- Uses modern iOS 16+ badge APIs with automatic fallback
- Type-safe Pigeon bindings instead of raw method channels

## Contributing

Contributions are welcome! Please follow the [Flutter style guide](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo) and submit a PR.

## License

MIT — see [LICENSE](LICENSE) for details.
