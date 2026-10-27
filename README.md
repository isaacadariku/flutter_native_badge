# flutter_native_badge

[![CI](https://github.com/isaacadariku/flutter_native_badge/actions/workflows/ci.yml/badge.svg)](https://github.com/isaacadariku/flutter_native_badge/actions/workflows/ci.yml)

A Flutter plugin for setting the app icon badge count on iOS, macOS, and Android.

**To use the plugin, see the [`flutter_native_badge`](flutter_native_badge/) package and its [pub.dev page](https://pub.dev/packages/flutter_native_badge).**

## Packages

This is a [federated plugin](https://docs.flutter.dev/packages-and-plugins/developing-packages#federated-plugins). This repo contains:

| Package | Description | pub.dev |
| --- | --- | --- |
| [`flutter_native_badge`](flutter_native_badge/) | The app-facing package. Add this one to your app. | [![pub](https://img.shields.io/pub/v/flutter_native_badge.svg)](https://pub.dev/packages/flutter_native_badge) |
| [`flutter_native_badge_platform_interface`](flutter_native_badge_platform_interface/) | The common interface that every platform implementation implements. | [![pub](https://img.shields.io/pub/v/flutter_native_badge_platform_interface.svg)](https://pub.dev/packages/flutter_native_badge_platform_interface) |
| [`flutter_native_badge_foundation`](flutter_native_badge_foundation/) | The iOS and macOS implementation. | [![pub](https://img.shields.io/pub/v/flutter_native_badge_foundation.svg)](https://pub.dev/packages/flutter_native_badge_foundation) |
| [`flutter_native_badge_android`](flutter_native_badge_android/) | The Android implementation. | [![pub](https://img.shields.io/pub/v/flutter_native_badge_android.svg)](https://pub.dev/packages/flutter_native_badge_android) |

## Contributing

Please [open an issue](https://github.com/isaacadariku/flutter_native_badge/issues) to discuss a change before submitting a pull request.

To work on the packages locally, link them to each other so that unpublished changes are used. From the repo root:

```sh
cat > flutter_native_badge/pubspec_overrides.yaml <<'YAML'
dependency_overrides:
  flutter_native_badge_android:
    path: ../flutter_native_badge_android
  flutter_native_badge_foundation:
    path: ../flutter_native_badge_foundation
  flutter_native_badge_platform_interface:
    path: ../flutter_native_badge_platform_interface
YAML
```

The example apps already point at the local packages.

Run the integration tests on a device or simulator from `flutter_native_badge/example`:

```sh
flutter test integration_test -d <device>
```

On iOS, the tests wait for the notification permission dialog, so allow it when it appears.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE).
