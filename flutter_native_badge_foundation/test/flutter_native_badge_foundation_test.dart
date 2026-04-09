import 'package:flutter/services.dart';
import 'package:flutter_native_badge_foundation/flutter_native_badge_foundation.dart';
import 'package:flutter_native_badge_platform_interface/flutter_native_badge_platform.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('registerWith sets instance', () {
    FlutterNativeBadgeFoundation.registerWith();
    expect(
      FlutterNativeBadgePlatform.instance,
      isA<FlutterNativeBadgeFoundation>(),
    );
  });

  group('FlutterNativeBadgeFoundation delegates to API', () {
    late FlutterNativeBadgeFoundation foundation;
    late List<String> log;

    setUp(() {
      log = <String>[];
      // Register mock handlers for each pigeon channel
      const channelPrefix =
          'dev.flutter.pigeon.flutter_native_badge_foundation.FlutterNativeBadgeApi';

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('$channelPrefix.requestPermission',
              (message) async {
        log.add('requestPermission');
        return const StandardMessageCodec().encodeMessage(<Object?>[null]);
      });

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('$channelPrefix.getBadgeCount',
              (message) async {
        log.add('getBadgeCount');
        return const StandardMessageCodec().encodeMessage(<Object?>[7]);
      });

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('$channelPrefix.setBadgeCount',
              (message) async {
        log.add('setBadgeCount');
        return const StandardMessageCodec().encodeMessage(<Object?>[null]);
      });

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('$channelPrefix.clearBadgeCount',
              (message) async {
        log.add('clearBadgeCount');
        return const StandardMessageCodec().encodeMessage(<Object?>[null]);
      });

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('$channelPrefix.showRedDot', (message) async {
        log.add('showRedDot');
        return const StandardMessageCodec().encodeMessage(<Object?>[null]);
      });

      foundation = FlutterNativeBadgeFoundation();
    });

    tearDown(() {
      const channelPrefix =
          'dev.flutter.pigeon.flutter_native_badge_foundation.FlutterNativeBadgeApi';
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
      await foundation.requestPermission();
      expect(log, ['requestPermission']);
    });

    test('getBadgeCount', () async {
      final count = await foundation.getBadgeCount();
      expect(count, 7);
      expect(log, ['getBadgeCount']);
    });

    test('setBadgeCount', () async {
      await foundation.setBadgeCount(5);
      expect(log, ['setBadgeCount']);
    });

    test('clearBadgeCount', () async {
      await foundation.clearBadgeCount();
      expect(log, ['clearBadgeCount']);
    });

    test('showRedDot', () async {
      await foundation.showRedDot();
      expect(log, ['showRedDot']);
    });
  });
}
