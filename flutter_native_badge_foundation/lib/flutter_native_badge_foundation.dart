
import 'flutter_native_badge_foundation_platform_interface.dart';

class FlutterNativeBadgeFoundation {
  Future<String?> getPlatformVersion() {
    return FlutterNativeBadgeFoundationPlatform.instance.getPlatformVersion();
  }
}
