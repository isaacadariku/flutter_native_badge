import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_native_badge_foundation/flutter_native_badge_foundation.dart';
import 'package:flutter_native_badge_foundation/flutter_native_badge_foundation_platform_interface.dart';
import 'package:flutter_native_badge_foundation/flutter_native_badge_foundation_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterNativeBadgeFoundationPlatform
    with MockPlatformInterfaceMixin
    implements FlutterNativeBadgeFoundationPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterNativeBadgeFoundationPlatform initialPlatform = FlutterNativeBadgeFoundationPlatform.instance;

  test('$MethodChannelFlutterNativeBadgeFoundation is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterNativeBadgeFoundation>());
  });

  test('getPlatformVersion', () async {
    FlutterNativeBadgeFoundation flutterNativeBadgeFoundationPlugin = FlutterNativeBadgeFoundation();
    MockFlutterNativeBadgeFoundationPlatform fakePlatform = MockFlutterNativeBadgeFoundationPlatform();
    FlutterNativeBadgeFoundationPlatform.instance = fakePlatform;

    expect(await flutterNativeBadgeFoundationPlugin.getPlatformVersion(), '42');
  });
}
