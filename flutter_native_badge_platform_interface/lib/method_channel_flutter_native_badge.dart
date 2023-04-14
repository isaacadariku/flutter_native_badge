import 'package:flutter/services.dart';
import 'package:flutter_native_badge_platform_interface/flutter_native_badge_platform.dart';

const MethodChannel _kChannel =
    MethodChannel('plugins.flutter.io/flutter_native_badge');

/// An implementation of [FlutterNativeBadgePlatform] that uses method channels.
class MethodChannelFlutterNativeBadge extends FlutterNativeBadgePlatform {
  @override
  Future<void> clearBadgeCount() async {
    await _kChannel.invokeMethod('clearBadgeCount');
  }

  @override
  Future<int> getBadgeCount() async {
    return await _kChannel.invokeMethod('getBadgeCount');
  }

  @override
  Future<void> setBadgeCount(int count) async {
    await _kChannel.invokeMethod('setBadgeCount', count);
  }

  @override
  Future<void> setBadgeRedDot() async {
    await _kChannel.invokeMethod('setBadgeRedDot');
  }
}
