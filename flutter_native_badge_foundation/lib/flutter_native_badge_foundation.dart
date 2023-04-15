import 'package:flutter_native_badge_foundation/flutter_native_badge_api.g.dart';
import 'package:flutter_native_badge_platform_interface/flutter_native_badge_platform.dart';

class FlutterNativeBadgeFoundation extends FlutterNativeBadgePlatform {
  final FlutterNativeBadgeApi _api = FlutterNativeBadgeApi();

  /// Registers this class as the default instance of
  /// [FlutterNativeBadgePlatform].
  static void registerWith() {
    FlutterNativeBadgePlatform.instance = FlutterNativeBadgeFoundation();
  }

  @override
  Future<void> clearBadgeCount() async {
    await _api.clearBadgeCount();
  }

  @override
  Future<int> getBadgeCount() async {
    return _api.getBadgeCount();
  }

  @override
  Future<void> setBadgeCount(int count) async {
    await _api.setBadgeCount(count);
  }

  @override
  Future<void> showRedDot() {
    return _api.showRedDot();
  }

  @override
  Future<void> requestPermission() {
    return _api.requestPermission();
  }
}
