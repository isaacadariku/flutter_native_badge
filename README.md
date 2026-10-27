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

The repo is a [pub workspace](https://dart.dev/tools/pub/workspaces). Run `flutter pub get` once from the repo root and every package, including the example apps, uses the local copies of the other packages, so unpublished changes are picked up without any overrides.

Run the integration tests on a device or simulator from `flutter_native_badge/example`:

```sh
flutter test integration_test -d <device>
```

On iOS, the tests wait for the notification permission dialog, so allow it when it appears.

## Releasing

Each package is versioned and released on its own, with a [GitHub release](https://github.com/isaacadariku/flutter_native_badge/releases) per version tagged `<package>-v<version>`, for example `flutter_native_badge-v2.1.0`.

1. Bump `version` in the package's `pubspec.yaml` and add a `CHANGELOG.md` entry.
2. Merge the change to `master`.
3. Create a GitHub release with the tag `<package>-v<version>` and the changelog entry as notes. Pushing the tag runs the [Publish](.github/workflows/publish.yml) workflow, which publishes the package to pub.dev.

When a change spans packages, release them in dependency order: `flutter_native_badge_platform_interface`, then the platform implementations, then `flutter_native_badge`. The workspace always uses the local packages, so when a package needs a change from another one, also raise its dependency constraint (for example `flutter_native_badge_android: ^2.2.0`) so that pub.dev users get the version that has the change.

The workflow uses [automated publishing](https://dart.dev/tools/pub/automated-publishing). Each package must have it enabled on its pub.dev admin page, with the repository `isaacadariku/flutter_native_badge`, the tag pattern `<package>-v{{version}}`, and the `pub.dev` environment required.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE).
