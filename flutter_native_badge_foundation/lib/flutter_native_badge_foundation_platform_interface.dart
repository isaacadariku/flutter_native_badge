import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_native_badge_foundation_method_channel.dart';

abstract class FlutterNativeBadgeFoundationPlatform extends PlatformInterface {
  /// Constructs a FlutterNativeBadgeFoundationPlatform.
  FlutterNativeBadgeFoundationPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterNativeBadgeFoundationPlatform _instance = MethodChannelFlutterNativeBadgeFoundation();

  /// The default instance of [FlutterNativeBadgeFoundationPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterNativeBadgeFoundation].
  static FlutterNativeBadgeFoundationPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterNativeBadgeFoundationPlatform] when
  /// they register themselves.
  static set instance(FlutterNativeBadgeFoundationPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
