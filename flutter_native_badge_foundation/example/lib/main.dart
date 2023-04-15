import 'dart:async';
import 'dart:io';

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

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    await _platform.requestPermission();

    int badgeCount = 0;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      badgeCount = await _platform.getBadgeCount();
    } on PlatformException {
      badgeCount = 0;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _badgeCount = badgeCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FNB Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text('Badge count: $_badgeCount'),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  await _platform.setBadgeCount(_badgeCount + 1);
                  _incrementCounter();
                },
                child: const Text('Increment'),
              ),
              const SizedBox(height: 20),
              if (_badgeCount > 0)
                ElevatedButton(
                  onPressed: () async {
                    await _platform.clearBadgeCount();
                    _resetCounter();
                  },
                  child: const Text('Clear'),
                ),
              if (Platform.isMacOS)
                ElevatedButton(
                  onPressed: () async {
                    await _platform.showRedDot();
                  },
                  child: const Text('Show Red Dot'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _incrementCounter() async {
    setState(() {
      _badgeCount++;
    });
  }

  Future<void> _resetCounter() async {
    setState(() {
      _badgeCount = 0;
    });
  }
}
