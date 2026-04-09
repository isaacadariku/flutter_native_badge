import 'package:flutter/foundation.dart';
import 'package:flutter_native_badge_platform_interface/flutter_native_badge_platform.dart';

class FlutterNativeBadge {
  static bool get isSupported {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS;
  }

  static void _ensureSupported() {
    if (!isSupported) {
      throw UnsupportedError('Platform not supported');
    }
  }

  /// Requests permission to show badges.
  ///
  /// On iOS, this will show a permission dialog.
  /// On macOS, this is a no-op.
  static Future<void> requestPermission() async {
    _ensureSupported();
    await FlutterNativeBadgePlatform.instance.requestPermission();
  }

  /// Gets the badge count of the app icon.
  ///
  /// On iOS, this depends on the deprecated `applicationIconBadgeNumber` API
  /// and may be unavailable in future iOS releases. Consider managing the badge
  /// count yourself via an external data source.
  @Deprecated(
    'On iOS, getBadgeCount depends on a deprecated API '
    '(applicationIconBadgeNumber) and may be unavailable in future iOS releases. '
    'Manage the badge count yourself via an external data source.',
  )
  static Future<int> getBadgeCount({bool requestPermission = false}) async {
    _ensureSupported();
    if (requestPermission) {
      await FlutterNativeBadgePlatform.instance.requestPermission();
    }
    return await FlutterNativeBadgePlatform.instance.getBadgeCount();
  }

  static Future<void> setBadgeCount(
    int count, {
    bool requestPermission = false,
  }) async {
    _ensureSupported();
    if (requestPermission) {
      await FlutterNativeBadgePlatform.instance.requestPermission();
    }
    await FlutterNativeBadgePlatform.instance.setBadgeCount(count);
  }

  static Future<void> clearBadgeCount({bool requestPermission = false}) async {
    _ensureSupported();
    if (requestPermission) {
      await FlutterNativeBadgePlatform.instance.requestPermission();
    }
    await FlutterNativeBadgePlatform.instance.clearBadgeCount();
  }

  static Future<void> showRedDot({bool requestPermission = false}) async {
    _ensureSupported();
    if (requestPermission) {
      await FlutterNativeBadgePlatform.instance.requestPermission();
    }
    await FlutterNativeBadgePlatform.instance.showRedDot();
  }
}
