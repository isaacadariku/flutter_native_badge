import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    input: 'pigeons/flutter_native_badge_api.dart',
    dartOut: 'lib/flutter_native_badge_api.g.dart',
    dartPackageName: 'flutter_native_badge_android',
    kotlinOut:
        'android/src/main/kotlin/io/flutter/plugins/flutter_native_badge_android/FlutterNativeBadge.g.kt',
    kotlinOptions: KotlinOptions(
      package: 'io.flutter.plugins.flutter_native_badge_android',
    ),
  ),
)
@HostApi()
abstract class FlutterNativeBadgeApi {
  @async
  void requestPermission();

  int getBadgeCount();

  void setBadgeCount(int count);

  void clearBadgeCount();

  void showRedDot();
}
