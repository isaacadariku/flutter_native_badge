# flutter_native_badge

[![pub package](https://img.shields.io/pub/v/flutter_native_badge.svg)](https://pub.dev/packages/flutter_native_badge)
[![pub points](https://img.shields.io/pub/points/flutter_native_badge)](https://pub.dev/packages/flutter_native_badge/score)
[![likes](https://img.shields.io/pub/likes/flutter_native_badge)](https://pub.dev/packages/flutter_native_badge)
[![downloads](https://img.shields.io/pub/dm/flutter_native_badge)](https://pub.dev/packages/flutter_native_badge/score)

A Flutter plugin that wraps native badge APIs on iOS, macOS, and Android. Set badge counts, show a red dot indicator, clear badges, and manage notification permissions — all through a simple Dart API.

## Features

- **Set badge count** — Display a numeric badge on your app icon
- **Show red dot** — Show a dot indicator without a number (macOS dock)
- **Clear badge** — Remove the badge from your app icon
- **Get badge count** — Read the current badge value
- **Request permission** — Handle iOS and Android notification permission prompts
- **Platform check** — Safely check if the current platform supports badges

## Platform Support

| Feature               |      iOS      |   macOS    |       Android        |
| --------------------- | :-----------: | :--------: | :------------------: |
| `setBadgeCount()`     |      ✅       |     ✅     |          ✅          |
| `clearBadgeCount()`   |      ✅       |     ✅     |          ✅          |
| `showRedDot()`        |   ❌ (no-op)   |     ✅     |   ✅ (shows `1`)     |
| `getBadgeCount()`     | ⚠️ Deprecated |     ✅     | ✅ (last value set)  |
| `requestPermission()` |      ✅       | ✅ (no-op) |    ✅ (API 33+)      |

Requires Flutter 3.44 or later. iOS and macOS support both Swift Package Manager and CocoaPods.

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
  flutter_native_badge: ^2.1.0
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

Returns `true` on iOS, macOS, and Android. Returns `false` on all other platforms. Use this before calling any other method to avoid `UnsupportedError`.

### Set badge count

```dart
await FlutterNativeBadge.setBadgeCount(5);
```

On iOS 16+, uses the modern `UNUserNotificationCenter.setBadgeCount` API. On earlier iOS versions, falls back to `applicationIconBadgeNumber`. On Android, see [how Android badges work](#android).

### Show red dot

```dart
await FlutterNativeBadge.showRedDot();
```

Shows a red dot indicator on the app icon without displaying a number. Useful for indicating new content.

On macOS, this also bounces the dock icon until the app is activated. Android launchers can't show a dot without a count, so this sets the badge count to `1`. On iOS, this is a no-op because iOS badges always show a number.

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

On Android, launchers can't be queried for the current badge, so this returns the last count set through this plugin.

### Request permission

```dart
await FlutterNativeBadge.requestPermission();
```

On iOS, presents the system notification permission dialog. On Android 13+ (API 33), requests the `POST_NOTIFICATIONS` runtime permission. On macOS, this is a no-op.

You can also pass `requestPermission: true` to any method to request permission inline:

```dart
await FlutterNativeBadge.setBadgeCount(5, requestPermission: true);
await FlutterNativeBadge.showRedDot(requestPermission: true);
await FlutterNativeBadge.clearBadgeCount(requestPermission: true);
```

## Permissions

### iOS

Badge counts on iOS require notification permissions. Call `requestPermission()` before setting a badge, or pass `requestPermission: true` to individual methods. No `Info.plist` changes are needed.

### macOS

No special permissions are required. Badge APIs work out of the box on macOS.

### Android

Android has no public API for setting an app icon badge. Most launchers (Samsung One UI, Pixel, Xiaomi, OPPO, vivo, ...) only badge an app icon while the app has an active notification. The plugin handles this for you:

- **Huawei and Honor** launchers: the count is set directly through the launcher's badge API. No notification is shown.
- **All other launchers** (Android 8.0+): the plugin posts a single silent, low-priority notification that carries the count, in a notification channel named *App icon badge*. The notification is removed when the badge is cleared, and tapping it opens your app.

Keep in mind:

- The badge notification is visible in the notification shade, and users can dismiss it (which also removes the badge).
- How the badge looks is up to the launcher and the user's settings. Some launchers show the number, others only a dot.
- The plugin adds the `POST_NOTIFICATIONS` permission to your app's manifest. On **Android 13+** (API 33), call `requestPermission()` (or pass `requestPermission: true`) so the user can grant it. Without it, the badge isn't shown on launchers that rely on notifications.
- If your app already shows its own notifications, the launcher badge counts those too.

## Migrating from flutter_app_badger

[`flutter_app_badger`](https://pub.dev/packages/flutter_app_badger) has been **discontinued**. Here's how to migrate:

```dart
// Before (flutter_app_badger)
FlutterAppBadger.updateBadgeCount(5);
FlutterAppBadger.removeBadge();
FlutterAppBadger.isAppBadgeSupported();

// After (flutter_native_badge)
await FlutterNativeBadge.setBadgeCount(5, requestPermission: true);
await FlutterNativeBadge.clearBadgeCount();
FlutterNativeBadge.isSupported; // synchronous getter
```

**Key differences:**

- `flutter_native_badge` uses a federated plugin architecture for better maintainability
- Built-in permission handling with `requestPermission` parameter
- `showRedDot()` for dot-only indicators on macOS
- Uses modern iOS 16+ badge APIs with automatic fallback
- Works on modern Android launchers (including Samsung One UI), which ignore the legacy launcher APIs `flutter_app_badger` relied on
- Type-safe Pigeon bindings instead of raw method channels

## Contributing

Contributions are welcome! Please [open an issue](https://github.com/isaacadariku/flutter_native_badge/issues) to discuss a change before submitting a pull request, and follow the [Flutter style guide](https://github.com/flutter/flutter/blob/main/docs/contributing/Style-guide-for-Flutter-repo.md).

## License

MIT — see [LICENSE](LICENSE) for details.
