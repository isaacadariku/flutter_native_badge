import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_badge/flutter_native_badge.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final bool _isSupported = FlutterNativeBadge.isSupported;
  int _badgeCount = 0;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (_isSupported) {
      _run(() async {
        await FlutterNativeBadge.requestPermission();
        await FlutterNativeBadge.clearBadgeCount();
        _badgeCount = 0;
      });
    }
  }

  // Platform messages are asynchronous, so report failures in the UI instead
  // of letting them escape.
  Future<void> _run(Future<void> Function() action) async {
    try {
      await action();
      _error = null;
    } on PlatformException catch (e) {
      _error = e.message ?? e.code;
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isSupported
                    ? 'Native badge is supported'
                    : 'Native badge is not supported',
              ),
              if (_isSupported) ...[
                const SizedBox(height: 20),
                Text(
                  'Badge count: $_badgeCount',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    'Error: $_error',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => _run(() async {
                    await FlutterNativeBadge.setBadgeCount(_badgeCount + 1);
                    _badgeCount++;
                  }),
                  child: const Text('Increment'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => _run(() async {
                    await FlutterNativeBadge.showRedDot();
                  }),
                  child: const Text('Show red dot'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => _run(() async {
                    await FlutterNativeBadge.clearBadgeCount();
                    _badgeCount = 0;
                  }),
                  child: const Text('Reset'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
