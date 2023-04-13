import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_native_badge_platform_interface.dart';

/// An implementation of [FlutterNativeBadgePlatform] that uses method channels.
class MethodChannelFlutterNativeBadge extends FlutterNativeBadgePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_native_badge');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
