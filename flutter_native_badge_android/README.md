# flutter_native_badge_android

[![pub package](https://img.shields.io/pub/v/flutter_native_badge_android.svg)](https://pub.dev/packages/flutter_native_badge_android)

The Android implementation of [`flutter_native_badge`](https://pub.dev/packages/flutter_native_badge).

## Usage

This package is [endorsed](https://flutter.dev/to/endorsed-federated-plugin), which means you can simply use `flutter_native_badge` normally. This package will be automatically included in your app when you do, so you do not need to add it to your `pubspec.yaml`.

However, if you import this package to use any of its APIs directly, you should add it to your `pubspec.yaml` as usual.

## How it works

Android has no public API for setting an app icon badge. Most launchers only badge an app icon while the app has an active notification, so this plugin:

- On **Huawei and Honor** launchers, sets the count through the launcher's badge API. No notification is shown.
- On **all other launchers** (Android 8.0+), posts a single silent, low-priority notification carrying the count, in a channel named *App icon badge*. It is removed when the badge is cleared, and tapping it opens the app.
- On **Android 13+** (API 33), `requestPermission()` requests the `POST_NOTIFICATIONS` runtime permission, which the notification needs.
- Stores the last count set, which `getBadgeCount()` returns.

`showRedDot()` sets the badge count to `1`, because Android launchers can't show a dot without a count.

## Permissions

The plugin adds these permissions to your app's manifest:

- `android.permission.POST_NOTIFICATIONS`
- `com.huawei.android.launcher.permission.CHANGE_BADGE`
- `com.hihonor.android.launcher.permission.CHANGE_BADGE`
