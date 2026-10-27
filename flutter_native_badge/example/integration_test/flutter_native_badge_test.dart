// Runs the plugin against the real platform implementations.
//
// flutter test integration_test -d <device>
//
// On iOS, grant notification permission to the example app first, otherwise
// `requestPermission` waits for the system dialog.

// getBadgeCount is deprecated on iOS but is the only way to read the badge back.
// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter_native_badge/flutter_native_badge.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/// iOS applies badge updates asynchronously, so poll until the badge matches.
Future<int> _badgeCountEventually(int expected) async {
  var count = await FlutterNativeBadge.getBadgeCount();
  for (var i = 0; i < 20 && count != expected; i++) {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    count = await FlutterNativeBadge.getBadgeCount();
  }
  return count;
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await FlutterNativeBadge.requestPermission();
  });

  tearDown(() async {
    await FlutterNativeBadge.clearBadgeCount();
  });

  testWidgets('is supported', (_) async {
    expect(FlutterNativeBadge.isSupported, isTrue);
  });

  testWidgets('setBadgeCount sets the badge', (_) async {
    await FlutterNativeBadge.setBadgeCount(5);
    expect(await _badgeCountEventually(5), 5);

    await FlutterNativeBadge.setBadgeCount(12);
    expect(await _badgeCountEventually(12), 12);
  });

  testWidgets('setBadgeCount(0) clears the badge', (_) async {
    await FlutterNativeBadge.setBadgeCount(3);
    expect(await _badgeCountEventually(3), 3);

    await FlutterNativeBadge.setBadgeCount(0);
    expect(await _badgeCountEventually(0), 0);
  });

  testWidgets('clearBadgeCount clears the badge', (_) async {
    await FlutterNativeBadge.setBadgeCount(8);
    expect(await _badgeCountEventually(8), 8);

    await FlutterNativeBadge.clearBadgeCount();
    expect(await _badgeCountEventually(0), 0);
  });

  testWidgets('showRedDot completes', (_) async {
    await FlutterNativeBadge.showRedDot();

    if (defaultTargetPlatform == TargetPlatform.android) {
      expect(await FlutterNativeBadge.getBadgeCount(), 1);
    }
  });
}
