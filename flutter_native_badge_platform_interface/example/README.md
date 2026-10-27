# Implementing a platform

Apps should use [`flutter_native_badge`](https://pub.dev/packages/flutter_native_badge). This package is for plugin authors who add support for another platform.

Extend `FlutterNativeBadgePlatform` and register your implementation when the plugin is loaded:

```dart
import 'package:flutter_native_badge_platform_interface/flutter_native_badge_platform.dart';

class FlutterNativeBadgeLinux extends FlutterNativeBadgePlatform {
  /// Called by Flutter when the plugin is registered (`dartPluginClass`).
  static void registerWith() {
    FlutterNativeBadgePlatform.instance = FlutterNativeBadgeLinux();
  }

  int _count = 0;

  @override
  Future<int> getBadgeCount() async => _count;

  @override
  Future<void> setBadgeCount(int count) async {
    _count = count;
    // Update the badge with the platform's API here.
  }

  @override
  Future<void> clearBadgeCount() => setBadgeCount(0);

  @override
  Future<void> showRedDot() => setBadgeCount(1);

  @override
  Future<void> requestPermission() async {}
}
```

Then declare it in your package's `pubspec.yaml`:

```yaml
flutter:
  plugin:
    implements: flutter_native_badge
    platforms:
      linux:
        dartPluginClass: FlutterNativeBadgeLinux
```
