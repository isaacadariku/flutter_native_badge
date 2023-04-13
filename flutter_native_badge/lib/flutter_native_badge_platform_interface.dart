import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_native_badge_method_channel.dart';

abstract class FlutterNativeBadgePlatform extends PlatformInterface {
  /// Constructs a FlutterNativeBadgePlatform.
  FlutterNativeBadgePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterNativeBadgePlatform _instance = MethodChannelFlutterNativeBadge();

  /// The default instance of [FlutterNativeBadgePlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterNativeBadge].
  static FlutterNativeBadgePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterNativeBadgePlatform] when
  /// they register themselves.
  static set instance(FlutterNativeBadgePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
