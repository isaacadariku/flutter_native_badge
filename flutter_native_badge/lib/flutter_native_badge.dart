import 'dart:io';

import 'package:flutter_native_badge_platform_interface/flutter_native_badge_platform.dart';

class FlutterNativeBadge {
  static Future<bool> isSupported() async {
    if (Platform.isIOS || Platform.isMacOS) {
      return true;
    } else {
      return false;
    }
  }

  static Future<int> getBadgeCount() async {
    if (!await isSupported()) {
      throw UnsupportedError('Platform not supported');
    }
    return await FlutterNativeBadgePlatform.instance.getBadgeCount();
  }

  static Future<void> setBadgeCount(int count) async {
    if (!await isSupported()) {
      throw UnsupportedError('Platform not supported');
    }
    await FlutterNativeBadgePlatform.instance.setBadgeCount(count);
  }

  static Future<void> clearBadgeCount() async {
    if (!await isSupported()) {
      throw UnsupportedError('Platform not supported');
    }
    await FlutterNativeBadgePlatform.instance.clearBadgeCount();
  }

  static Future<void> setBadgeRedDot() async {
    if (!await isSupported()) {
      throw UnsupportedError('Platform not supported');
    }
    await FlutterNativeBadgePlatform.instance.setBadgeRedDot();
  }
}
