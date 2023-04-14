import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'method_channel_flutter_native_badge.dart';

/// The interface that implementations of flutter_native_badge must implement.
///
/// Platform implementations should extend this class rather than implement it as `flutter_native_badge`
/// does not consider newly added methods to be breaking changes. Extending this class
/// (using `extends`) ensures that the subclass will get the default implementation, while
/// platform implementations that `implements` this interface will be broken by newly added
/// [FlutterNativeBadgePlatform] methods.
abstract class FlutterNativeBadgePlatform extends PlatformInterface {
  /// Constructs a FlutterNativeBadgePlatform.
  FlutterNativeBadgePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterNativeBadgePlatform _instance =
      MethodChannelFlutterNativeBadge();

  /// The default instance of [FlutterNativeBadgePlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterNativeBadgePlatformInterface].
  static FlutterNativeBadgePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterNativeBadgePlatform] when
  /// they register themselves.
  static set instance(FlutterNativeBadgePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Gets the badge count of the app icon.
  /// Returns 0 if the badge count is not set.
  Future<int> getBadgeCount();

  /// Sets the badge count of the app icon.
  /// On iOS, this will also show a red dot on top of the app icon.
  ///
  Future<void> setBadgeCount(int count);

  /// Set the badge of the app icon to red dot.
  Future<void> setBadgeRedDot();

  /// Clears the badge count of the app icon.
  /// This will also hide the red dot on top of the app icon.
  /// and set the badge count to 0.
  Future<void> clearBadgeCount();
}
