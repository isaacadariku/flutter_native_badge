  import Flutter
  import UIKit


public class FlutterNativeBadgePlugin: NSObject, FlutterPlugin, FlutterNativeBadgeApi {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let api: FlutterNativeBadgePlugin = FlutterNativeBadgePlugin()
    let messenger = registrar.messenger()
    FlutterNativeBadgeApiSetup.setUp(binaryMessenger: messenger, api: api)
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
    UIApplication.shared.applicationIconBadgeNumber = -1
  }
}
