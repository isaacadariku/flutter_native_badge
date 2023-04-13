import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_native_badge_foundation_platform_interface.dart';

/// An implementation of [FlutterNativeBadgeFoundationPlatform] that uses method channels.
class MethodChannelFlutterNativeBadgeFoundation extends FlutterNativeBadgeFoundationPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_native_badge_foundation');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
