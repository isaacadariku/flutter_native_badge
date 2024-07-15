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
  bool _isSupported = false;
  int _badgeCount = 0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    bool isSupported;

    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      isSupported = await FlutterNativeBadge.isSupported();
      if (isSupported) {
        await FlutterNativeBadge.clearBadgeCount();
      }
    } on PlatformException {
      isSupported = false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _isSupported = isSupported;
      _badgeCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              if (_isSupported)
                const Text('Native badge is supported')
              else
                const Text('Native badge is not supported'),
              const SizedBox(height: 20),
              if (_isSupported) Text('Badge count: $_badgeCount'),
              const SizedBox(height: 20),
              if (_isSupported) ...[
                ElevatedButton(
                  onPressed: () async {
                    await FlutterNativeBadge.setBadgeCount(_badgeCount + 1);
                    _incrementCounter();
                  },
                  child: const Text('Increment'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await FlutterNativeBadge.clearBadgeCount();
                    _resetCounter();
                  },
                  child: const Text('Reset'),
                ),
              ],
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
