import Flutter
import UIKit


public class FlutterNativeBadgePlugin: NSObject, FlutterPlugin, FlutterNativeBadgeApi {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let api: FlutterNativeBadgePlugin = FlutterNativeBadgePlugin()
    let messenger = registrar.messenger()
    FlutterNativeBadgeApiSetup.setUp(binaryMessenger: messenger, api: api)
  }

  func requestPermission(completion: @escaping (Result<Void, Error>) -> Void) {
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) { (granted, error) in
      if let error = error {
        completion(.failure(error))
        return
      }
      if granted {
        DispatchQueue.main.async {
          UIApplication.shared.registerForRemoteNotifications()
        }
      }
      completion(.success(()))
    }
  }

  func getBadgeCount() -> Int64 {
    // applicationIconBadgeNumber has been deprecated since iOS 17.
    // There is no direct replacement, so this function may be unavailable in future iOS releases.
    let badgeCount = Int64(UIApplication.shared.applicationIconBadgeNumber)
    return badgeCount
  }

  func setBadgeCount(count: Int64) {
    let count = Int(truncatingIfNeeded: count)

    if #available(iOS 16.0, *) {
      UNUserNotificationCenter.current().setBadgeCount(count)
    } else {
      UIApplication.shared.applicationIconBadgeNumber = count
    }
  }

  func clearBadgeCount() {
    if #available(iOS 16.0, *) {
      UNUserNotificationCenter.current().setBadgeCount(0)
    } else {
      UIApplication.shared.applicationIconBadgeNumber = 0
    }
  }

  func showRedDot() {
    // No-op on iOS
  }
}
