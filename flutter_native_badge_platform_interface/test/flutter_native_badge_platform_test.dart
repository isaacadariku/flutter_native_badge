import 'package:flutter_native_badge_platform_interface/flutter_native_badge_platform.dart';
import 'package:flutter_native_badge_platform_interface/method_channel_flutter_native_badge.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterNativeBadgePlatform
    with MockPlatformInterfaceMixin
    implements FlutterNativeBadgePlatform {
  int? lastSetCount;
  bool clearCalled = false;
  bool showRedDotCalled = false;
  bool requestPermissionCalled = false;

  @override
  Future<int> getBadgeCount() {
    return Future.value(42);
  }

  @override
  Future<void> setBadgeCount(int count) {
    lastSetCount = count;
    return Future.value(null);
  }

  @override
  Future<void> clearBadgeCount() {
    clearCalled = true;
    return Future.value(null);
  }

  @override
  Future<void> showRedDot() {
    showRedDotCalled = true;
    return Future.value(null);
  }

  @override
  Future<void> requestPermission() {
    requestPermissionCalled = true;
    return Future.value(null);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final FlutterNativeBadgePlatform initialPlatform =
      FlutterNativeBadgePlatform.instance;

  late MockFlutterNativeBadgePlatform mockPlatform;

  setUp(() {
    mockPlatform = MockFlutterNativeBadgePlatform();
    FlutterNativeBadgePlatform.instance = mockPlatform;
  });

  tearDown(() {
    FlutterNativeBadgePlatform.instance = initialPlatform;
  });

  test('$MethodChannelFlutterNativeBadge is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterNativeBadge>());
  });

  test('Can be overridden', () {
    expect(FlutterNativeBadgePlatform.instance,
        isInstanceOf<MockFlutterNativeBadgePlatform>());
  });

  test('Can be reset', () {
    FlutterNativeBadgePlatform.instance = initialPlatform;
    expect(FlutterNativeBadgePlatform.instance,
        isInstanceOf<MethodChannelFlutterNativeBadge>());
  });

  test('getBadgeCount returns expected value', () async {
    expect(await FlutterNativeBadgePlatform.instance.getBadgeCount(), 42);
  });

  test('setBadgeCount delegates to platform', () async {
    await FlutterNativeBadgePlatform.instance.setBadgeCount(5);
    expect(mockPlatform.lastSetCount, 5);
  });

  test('clearBadgeCount delegates to platform', () async {
    await FlutterNativeBadgePlatform.instance.clearBadgeCount();
    expect(mockPlatform.clearCalled, isTrue);
  });

  test('showRedDot delegates to platform', () async {
    await FlutterNativeBadgePlatform.instance.showRedDot();
    expect(mockPlatform.showRedDotCalled, isTrue);
  });

  test('requestPermission delegates to platform', () async {
    await FlutterNativeBadgePlatform.instance.requestPermission();
    expect(mockPlatform.requestPermissionCalled, isTrue);
  });
}
