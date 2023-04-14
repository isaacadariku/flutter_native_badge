import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    input: 'pigeons/flutter_native_badge_api.dart',
    dartOut: 'lib/flutter_native_badge_api.g.dart',
    swiftOut: 'darwin/Classes/FlutterNativeBadge.g.swift',
  ),
)
@HostApi()
abstract class FlutterNativeBadgeApi {
  int getBadgeCount();

  void setBadgeCount(int count);

  void clearBadgeCount();

  void showRedDot();
}
