import 'package:flutter/foundation.dart';
import 'package:flutter_native_badge/flutter_native_badge.dart';
import 'package:flutter_native_badge_platform_interface/flutter_native_badge_platform.dart';
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
  Future<int> getBadgeCount() => Future.value(42);

  @override
  Future<void> setBadgeCount(int count) {
    lastSetCount = count;
    return Future.value();
  }

  @override
  Future<void> clearBadgeCount() {
    clearCalled = true;
    return Future.value();
  }

  @override
  Future<void> showRedDot() {
    showRedDotCalled = true;
    return Future.value();
  }

  @override
  Future<void> requestPermission() {
    requestPermissionCalled = true;
    return Future.value();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockFlutterNativeBadgePlatform mockPlatform;
  late FlutterNativeBadgePlatform originalPlatform;

  setUp(() {
    originalPlatform = FlutterNativeBadgePlatform.instance;
    mockPlatform = MockFlutterNativeBadgePlatform();
    FlutterNativeBadgePlatform.instance = mockPlatform;
  });

  tearDown(() {
    FlutterNativeBadgePlatform.instance = originalPlatform;
    debugDefaultTargetPlatformOverride = null;
  });

  group('isSupported', () {
    test('returns true on iOS', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      expect(FlutterNativeBadge.isSupported, isTrue);
    });

    test('returns true on macOS', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
      expect(FlutterNativeBadge.isSupported, isTrue);
    });

    test('returns false on Android', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      expect(FlutterNativeBadge.isSupported, isFalse);
    });

    test('returns false on Linux', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.linux;
      expect(FlutterNativeBadge.isSupported, isFalse);
    });
  });

  group('on unsupported platform', () {
    setUp(() {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
    });

    test('setBadgeCount throws UnsupportedError', () {
      expect(
        () => FlutterNativeBadge.setBadgeCount(1),
        throwsA(isA<UnsupportedError>()),
      );
    });

    test('clearBadgeCount throws UnsupportedError', () {
      expect(
        () => FlutterNativeBadge.clearBadgeCount(),
        throwsA(isA<UnsupportedError>()),
      );
    });

    test('showRedDot throws UnsupportedError', () {
      expect(
        () => FlutterNativeBadge.showRedDot(),
        throwsA(isA<UnsupportedError>()),
      );
    });

    test('requestPermission throws UnsupportedError', () {
      expect(
        () => FlutterNativeBadge.requestPermission(),
        throwsA(isA<UnsupportedError>()),
      );
    });
  });

  group('on supported platform', () {
    setUp(() {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    });

    test('requestPermission delegates to platform', () async {
      await FlutterNativeBadge.requestPermission();
      expect(mockPlatform.requestPermissionCalled, isTrue);
    });

    // ignore: deprecated_member_use_from_same_package
    test('getBadgeCount delegates to platform', () async {
      // ignore: deprecated_member_use_from_same_package
      final count = await FlutterNativeBadge.getBadgeCount();
      expect(count, 42);
    });

    test('setBadgeCount delegates to platform', () async {
      await FlutterNativeBadge.setBadgeCount(5);
      expect(mockPlatform.lastSetCount, 5);
    });

    test('setBadgeCount with requestPermission calls both', () async {
      await FlutterNativeBadge.setBadgeCount(3, requestPermission: true);
      expect(mockPlatform.requestPermissionCalled, isTrue);
      expect(mockPlatform.lastSetCount, 3);
    });

    test('clearBadgeCount delegates to platform', () async {
      await FlutterNativeBadge.clearBadgeCount();
      expect(mockPlatform.clearCalled, isTrue);
    });

    test('showRedDot delegates to platform', () async {
      await FlutterNativeBadge.showRedDot();
      expect(mockPlatform.showRedDotCalled, isTrue);
    });
  });
}
