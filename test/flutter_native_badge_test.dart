import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_native_badge/flutter_native_badge.dart';
import 'package:flutter_native_badge/flutter_native_badge_platform_interface.dart';
import 'package:flutter_native_badge/flutter_native_badge_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterNativeBadgePlatform
    with MockPlatformInterfaceMixin
    implements FlutterNativeBadgePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterNativeBadgePlatform initialPlatform = FlutterNativeBadgePlatform.instance;

  test('$MethodChannelFlutterNativeBadge is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterNativeBadge>());
  });

  test('getPlatformVersion', () async {
    FlutterNativeBadge flutterNativeBadgePlugin = FlutterNativeBadge();
    MockFlutterNativeBadgePlatform fakePlatform = MockFlutterNativeBadgePlatform();
    FlutterNativeBadgePlatform.instance = fakePlatform;

    expect(await flutterNativeBadgePlugin.getPlatformVersion(), '42');
  });
}
