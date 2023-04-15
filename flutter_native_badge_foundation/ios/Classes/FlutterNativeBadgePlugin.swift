  import Flutter
  import UIKit


public class FlutterNativeBadgePlugin: NSObject, FlutterPlugin, FlutterNativeBadgeApi {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let api: FlutterNativeBadgePlugin = FlutterNativeBadgePlugin()
    let messenger = registrar.messenger()
    FlutterNativeBadgeApiSetup.setUp(binaryMessenger: messenger, api: api)
  }

  func requestPermission() {
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) { (granted, error) in
        if granted {
          DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
          }
        }
      }
    } else {
      UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge], categories: nil))
      UIApplication.shared.registerForRemoteNotifications()
    }
  }

  func getBadgeCount() -> Int64 {
    let badgeCount = Int64(UIApplication.shared.applicationIconBadgeNumber)
    return badgeCount
  }

  func setBadgeCount(count: Int64) {
    UIApplication.shared.applicationIconBadgeNumber = Int(truncatingIfNeeded: count)
  }

  func clearBadgeCount() {
    UIApplication.shared.applicationIconBadgeNumber = 0
  }

  func showRedDot() {
    // No-op
  }
}
