
import 'flutter_native_badge_platform_interface.dart';

class FlutterNativeBadge {
  Future<String?> getPlatformVersion() {
    return FlutterNativeBadgePlatform.instance.getPlatformVersion();
  }
}
