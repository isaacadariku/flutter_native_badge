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
  /// Defaults to [MethodChannelFlutterNativeBadge].
  static FlutterNativeBadgePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterNativeBadgePlatform] when
  /// they register themselves.
  static set instance(FlutterNativeBadgePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Gets the badge count of the app icon.
  ///
  /// Returns `0` if no badge is set.
  Future<int> getBadgeCount();

  /// Sets the badge count of the app icon.
  ///
  /// A [count] of `0` clears the badge.
  Future<void> setBadgeCount(int count);

  /// Shows a dot on the app icon without a count, where the platform
  /// supports it.
  Future<void> showRedDot();

  /// Clears the badge from the app icon and sets the badge count to `0`.
  Future<void> clearBadgeCount();

  /// Requests permission to show badges, if the platform requires it.
  ///
  /// Completes once the user has responded, whether or not permission was
  /// granted.
  Future<void> requestPermission();
}
