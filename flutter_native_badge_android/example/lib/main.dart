import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_badge_platform_interface/flutter_native_badge_platform.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterNativeBadgePlatform _platform =
      FlutterNativeBadgePlatform.instance;
  int _badgeCount = 0;
  String _status = 'Initializing...';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    try {
      await _platform.requestPermission();
      final count = await _platform.getBadgeCount();
      if (!mounted) return;
      setState(() {
        _badgeCount = count;
        _status = 'Ready';
      });
    } on PlatformException catch (e) {
      if (!mounted) return;
      setState(() {
        _status = 'Error: ${e.message}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('FNB Android Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Status: $_status'),
              const SizedBox(height: 20),
              Text(
                'Badge count: $_badgeCount',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await _platform.setBadgeCount(_badgeCount + 1);
                    setState(() => _badgeCount++);
                  } on PlatformException catch (e) {
                    setState(() => _status = 'Error: ${e.message}');
                  }
                },
                child: const Text('Increment'),
              ),
              const SizedBox(height: 20),
              if (_badgeCount > 0)
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await _platform.clearBadgeCount();
                      setState(() => _badgeCount = 0);
                    } on PlatformException catch (e) {
                      setState(() => _status = 'Error: ${e.message}');
                    }
                  },
                  child: const Text('Clear'),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await _platform.showRedDot();
                    setState(() => _status = 'Red dot shown');
                  } on PlatformException catch (e) {
                    setState(() => _status = 'Error: ${e.message}');
                  }
                },
                child: const Text('Show Red Dot'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
