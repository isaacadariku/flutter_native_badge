## 2.1.0 - 27th October 2026

- Initial release of the Android implementation of `flutter_native_badge` ([#7](https://github.com/isaacadariku/flutter_native_badge/issues/7))
- Sets the badge through the launcher badge API on Huawei and Honor devices
- Shows the badge through a silent notification on all other launchers (Android 8.0+), including Samsung One UI and Pixel
- `requestPermission()` requests `POST_NOTIFICATIONS` on Android 13+ (API 33)
- `getBadgeCount()` returns the last count set
- Requires Flutter 3.44.0 or later
