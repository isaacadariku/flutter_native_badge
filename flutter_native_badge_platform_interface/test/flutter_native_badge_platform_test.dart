import 'package:flutter_native_badge_platform_interface/flutter_native_badge_platform.dart';
import 'package:flutter_native_badge_platform_interface/method_channel_flutter_native_badge.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterNativeBadgePlatform
    with MockPlatformInterfaceMixin
    implements FlutterNativeBadgePlatform {
  @override
  Future<int> getBadgeCount() {
    return Future.value(42);
  }

  @override
  Future<void> setBadgeCount(int count) {
    return Future.value(null);
  }

  @override
  Future<void> clearBadgeCount() {
    return Future.value(null);
  }

  @override
  Future<void> setBadgeRedDot() {
    return Future.value(null);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final FlutterNativeBadgePlatform initialPlatform =
      FlutterNativeBadgePlatform.instance;

  void setupFlutterNativeBadge() {
    MockFlutterNativeBadgePlatform mockPlatform =
        MockFlutterNativeBadgePlatform();
    FlutterNativeBadgePlatform.instance = mockPlatform;
  }

  test('$MethodChannelFlutterNativeBadge is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterNativeBadge>());
  });

  test('Can be overridden', () {
    setupFlutterNativeBadge();
    expect(FlutterNativeBadgePlatform.instance,
        isInstanceOf<MockFlutterNativeBadgePlatform>());
  });

  test('Can be reset', () {
    FlutterNativeBadgePlatform.instance = initialPlatform;
    expect(FlutterNativeBadgePlatform.instance,
        isInstanceOf<MethodChannelFlutterNativeBadge>());
  });

  test('getBadgeCount', () async {
    setupFlutterNativeBadge();
    expect(await FlutterNativeBadgePlatform.instance.getBadgeCount(), 42);
  });
}
