import 'package:flutter/services.dart';
import 'package:flutter_native_badge_android/flutter_native_badge_android.dart';
import 'package:flutter_native_badge_platform_interface/flutter_native_badge_platform.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('registerWith sets instance', () {
    FlutterNativeBadgeAndroid.registerWith();
    expect(
      FlutterNativeBadgePlatform.instance,
      isA<FlutterNativeBadgeAndroid>(),
    );
  });

  group('FlutterNativeBadgeAndroid delegates to API', () {
    late FlutterNativeBadgeAndroid android;
    late List<String> log;

    setUp(() {
      log = <String>[];
      const channelPrefix =
          'dev.flutter.pigeon.flutter_native_badge_android.FlutterNativeBadgeApi';

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('$channelPrefix.requestPermission', (
            message,
          ) async {
            log.add('requestPermission');
            return const StandardMessageCodec().encodeMessage(<Object?>[null]);
          });

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('$channelPrefix.getBadgeCount', (
            message,
          ) async {
            log.add('getBadgeCount');
            return const StandardMessageCodec().encodeMessage(<Object?>[7]);
          });

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('$channelPrefix.setBadgeCount', (
            message,
          ) async {
            log.add('setBadgeCount');
            return const StandardMessageCodec().encodeMessage(<Object?>[null]);
          });

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('$channelPrefix.clearBadgeCount', (
            message,
          ) async {
            log.add('clearBadgeCount');
            return const StandardMessageCodec().encodeMessage(<Object?>[null]);
          });

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('$channelPrefix.showRedDot', (message) async {
            log.add('showRedDot');
            return const StandardMessageCodec().encodeMessage(<Object?>[null]);
          });

      android = FlutterNativeBadgeAndroid();
    });

    tearDown(() {
      const channelPrefix =
          'dev.flutter.pigeon.flutter_native_badge_android.FlutterNativeBadgeApi';
      for (final method in [
        'requestPermission',
        'getBadgeCount',
        'setBadgeCount',
        'clearBadgeCount',
        'showRedDot',
      ]) {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMessageHandler('$channelPrefix.$method', null);
      }
    });

    test('requestPermission', () async {
      await android.requestPermission();
      expect(log, ['requestPermission']);
    });

    test('getBadgeCount', () async {
      final count = await android.getBadgeCount();
      expect(count, 7);
      expect(log, ['getBadgeCount']);
    });

    test('setBadgeCount', () async {
      await android.setBadgeCount(5);
      expect(log, ['setBadgeCount']);
    });

    test('clearBadgeCount', () async {
      await android.clearBadgeCount();
      expect(log, ['clearBadgeCount']);
    });

    test('showRedDot', () async {
      await android.showRedDot();
      expect(log, ['showRedDot']);
    });
  });
}
