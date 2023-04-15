# flutter_native_badge_platform_interface

A common platform interface for the flutter_native_badge plugin.

This interface allows platform-specific implementations of the flutter_native_badge plugin, as well as the plugin itself, to ensure they are supporting the same interface.

## Usage

To implement a new platform-specific implementation of `flutter_native_badge`, extend [FlutterNativeBadgePlatform](https://github.com/isaacadariku/flutter_native_badge/blob/master/flutter_native_badge_platform_interface/lib/flutter_native_badge_platform.dart) with an implementation that performs the platform-specific behavior, and when you register your plugin, set the default `FlutterNativeBadgePlatform` by calling `FlutterNativeBadgePlatform.instance = MyPlatformFlutterNativeBadge()`.

## Note for maintainers

Strongly prefer non-breaking changes (such as adding methods) to breaking changes (such as changing method signatures or removing methods).

See the [Flutter Breaking changes](https://flutter.dev/go/platform-interface-breaking-changes) section of the [versioning guide](https://flutter.dev/docs/development/packages-and-plugins/versioning) for more information and why this is important.
