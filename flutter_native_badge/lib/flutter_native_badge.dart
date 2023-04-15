import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_native_badge_platform_interface/flutter_native_badge_platform.dart';

class FlutterNativeBadge {
  static Future<bool> isSupported() async {
    if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
      return true;
    } else {
      return false;
    }
  }

  static Future<int> getBadgeCount({bool requestPermission = false}) async {
    checkPlatformAndRequestPermission(requestPermission);

    return await FlutterNativeBadgePlatform.instance.getBadgeCount();
  }

  static Future<void> setBadgeCount(
    int count, {
    bool requestPermission = false,
  }) async {
    checkPlatformAndRequestPermission(requestPermission);

    await FlutterNativeBadgePlatform.instance.setBadgeCount(count);
  }

  static Future<void> clearBadgeCount({bool requestPermission = false}) async {
    checkPlatformAndRequestPermission(requestPermission);

    await FlutterNativeBadgePlatform.instance.clearBadgeCount();
  }

  static Future<void> showRedDot({bool requestPermission = false}) async {
    checkPlatformAndRequestPermission(requestPermission);

    await FlutterNativeBadgePlatform.instance.showRedDot();
  }
}

/// Check if the platform is supported and request permission if needed
@visibleForTesting
Future<void> checkPlatformAndRequestPermission(
  bool requestPermission,
) async {
  if (!await FlutterNativeBadge.isSupported()) {
    throw UnsupportedError('Platform not supported');
  }

  if (requestPermission) {
    await FlutterNativeBadgePlatform.instance.requestPermission();
  }
}
