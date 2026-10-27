/// A Flutter plugin for managing native app icon badges.
///
/// This library provides a cross-platform API for setting, getting, and
/// clearing badge counts on the app icon. Supports iOS, macOS, and Android.
///
/// See [FlutterNativeBadge] for usage details.
library;

import 'package:flutter/foundation.dart';
import 'package:flutter_native_badge_platform_interface/flutter_native_badge_platform.dart';

/// A Flutter plugin for managing native app icon badges on iOS, macOS, and Android.
///
/// Provides a simple API to set, get, and clear badge counts, show a red dot
/// indicator, and request notification permissions.
///
/// All methods check for platform support and throw [UnsupportedError] if
/// called on an unsupported platform. Use [isSupported] to check first.
///
/// ```dart
/// if (FlutterNativeBadge.isSupported) {
///   await FlutterNativeBadge.setBadgeCount(5);
/// }
/// ```
class FlutterNativeBadge {
  /// This class is not meant to be instantiated.
  FlutterNativeBadge._();

  /// Whether the current platform supports native badge APIs.
  ///
  /// Returns `true` on iOS, macOS, and Android. Returns `false` on all other
  /// platforms including web.
  static bool get isSupported {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.android;
  }

  static void _ensureSupported() {
    if (!isSupported) {
      throw UnsupportedError('Platform not supported');
    }
  }

  /// Requests permission to show badges on the app icon.
  ///
  /// On iOS, this presents the system notification permission dialog.
  /// On Android 13+ (API 33), this requests the `POST_NOTIFICATIONS` runtime
  /// permission, which most launchers need to show the badge.
  /// On macOS, this is a no-op as badges do not require explicit permission.
  ///
  /// Completes once the user has responded, whether or not permission was
  /// granted.
  ///
  /// ```dart
  /// await FlutterNativeBadge.requestPermission();
  /// ```
  static Future<void> requestPermission() async {
    _ensureSupported();
    await FlutterNativeBadgePlatform.instance.requestPermission();
  }

  /// Gets the current badge count of the app icon.
  ///
  /// Returns the badge count, or `0` if no badge is set.
  ///
  /// If [requestPermission] is `true`, requests notification permission
  /// before reading the badge count.
  ///
  /// On Android, launchers can't be queried, so this returns the last count
  /// set through this plugin.
  ///
  /// **Note:** On iOS, this depends on the deprecated
  /// `applicationIconBadgeNumber` API and may be unavailable in future iOS
  /// releases. Consider managing the badge count yourself via an external
  /// data source.
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

  /// Sets the badge count on the app icon.
  ///
  /// [count] is the number to display on the badge. Pass `0` to clear the
  /// badge (or use [clearBadgeCount]).
  ///
  /// If [requestPermission] is `true`, requests notification permission
  /// before setting the badge count.
  ///
  /// On iOS 16+, uses `UNUserNotificationCenter.setBadgeCount`.
  /// On earlier iOS versions, falls back to `applicationIconBadgeNumber`.
  /// On Android, uses the launcher badge API on Huawei and Honor devices, and
  /// a silent notification carrying the count on all other launchers.
  ///
  /// ```dart
  /// await FlutterNativeBadge.setBadgeCount(5);
  /// ```
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

  /// Clears the badge count from the app icon, setting it to `0`.
  ///
  /// If [requestPermission] is `true`, requests notification permission
  /// before clearing the badge.
  ///
  /// ```dart
  /// await FlutterNativeBadge.clearBadgeCount();
  /// ```
  static Future<void> clearBadgeCount({bool requestPermission = false}) async {
    _ensureSupported();
    if (requestPermission) {
      await FlutterNativeBadgePlatform.instance.requestPermission();
    }
    await FlutterNativeBadgePlatform.instance.clearBadgeCount();
  }

  /// Shows a red dot indicator on the app icon without a number.
  ///
  /// This is useful when you want to indicate new content without showing
  /// a specific count. On macOS, this displays a red dot on the dock icon and
  /// bounces the icon until the app is activated. On Android, launchers can't
  /// show a dot without a count, so this sets the badge count to `1`. On iOS,
  /// this is a no-op because iOS badges always show a number.
  ///
  /// If [requestPermission] is `true`, requests notification permission
  /// before showing the red dot.
  ///
  /// ```dart
  /// await FlutterNativeBadge.showRedDot();
  /// ```
  static Future<void> showRedDot({bool requestPermission = false}) async {
    _ensureSupported();
    if (requestPermission) {
      await FlutterNativeBadgePlatform.instance.requestPermission();
    }
    await FlutterNativeBadgePlatform.instance.showRedDot();
  }
}
