# flutter_native_badge

Wrapper for native badge APIs on iOS and macOS. It allows you to change the badge of your app icon, by setting the count, showing red dot, clearing the badge and getting the current badge count.

It supports iOS and macOS for now. Other platforms are not supported yet.

## Preview

<table width="100%">
  <thead>
    <tr>
      <th width="50%">Ios App</th>
      <th width="50%">MacOs App</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td width="50%"><img src="https://user-images.githubusercontent.com/46024202/232333138-4b44a8d0-3121-434f-a863-2e74c8078d38.gif"/></td>
      <td width="50%"><img src="https://user-images.githubusercontent.com/46024202/232332734-430e8296-ce3b-4a86-a25b-5c30c3738b7c.gif"/></td>
    </tr>
  </tbody>
</table>

## Usage

Before using any of the methods, you should check if the platform is supported. If not, the methods will throw an unsupported exception.

Each method will check if the permission is granted if you set the `requestPermission` parameter to true. If not, it will not request the permission and the method may not work if the permission is not granted.

### Import

```dart
import 'package:flutter_native_badge/flutter_native_badge.dart';
```

### Check if the platform is supported

```dart
bool isSupported = await FlutterNativeBadge.isSupported();
```

### Set badge count

```dart
FlutterNativeBadge.setBadgeCount(5);
```

### Show red dot

```dart
FlutterNativeBadge.showRedDot();
```

### Clear badge count

```dart
FlutterNativeBadge.clearBadgeCount();
```

### Get badge count

```dart
int badgeCount = await FlutterNativeBadge.getBadgeCount();
```

### Request permission

Each method has a `requestPermission` parameter. If you set it to true, it will request the permission if it is not granted.

```dart
FlutterNativeBadge.setBadgeCount(5, requestPermission: true);

FlutterNativeBadge.showRedDot(requestPermission: true);

FlutterNativeBadge.clearBadgeCount(requestPermission: true);

int badgeCount = await FlutterNativeBadge.getBadgeCount(requestPermission: true);
```

## Contributing

Contributions are welcome! Please follow the Flutter & Dart standard and make a PR.
