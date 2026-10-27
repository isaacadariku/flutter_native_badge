import 'package:flutter_native_badge_android/flutter_native_badge_api.g.dart';
import 'package:flutter_native_badge_platform_interface/flutter_native_badge_platform.dart';

/// The Android implementation of [FlutterNativeBadgePlatform].
///
/// This class implements the `flutter_native_badge` plugin functionality
/// for Android using Pigeon-generated bindings that communicate with
/// the native Android notification system.
class FlutterNativeBadgeAndroid extends FlutterNativeBadgePlatform {
  /// Creates a new [FlutterNativeBadgeAndroid] instance.
  ///
  /// Optionally accepts a [FlutterNativeBadgeApi] for testing purposes.
  FlutterNativeBadgeAndroid({FlutterNativeBadgeApi? api})
    : _api = api ?? FlutterNativeBadgeApi();

  final FlutterNativeBadgeApi _api;

  /// Registers this class as the default instance of
  /// [FlutterNativeBadgePlatform].
  static void registerWith() {
    FlutterNativeBadgePlatform.instance = FlutterNativeBadgeAndroid();
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
