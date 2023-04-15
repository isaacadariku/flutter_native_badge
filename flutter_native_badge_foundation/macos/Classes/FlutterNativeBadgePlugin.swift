import FlutterMacOS
import Foundation

public class FlutterNativeBadgePlugin: NSObject, FlutterPlugin, FlutterNativeBadgeApi {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let api: FlutterNativeBadgePlugin = FlutterNativeBadgePlugin()
    let messenger = registrar.messenger

    FlutterNativeBadgeApiSetup.setUp(binaryMessenger: messenger, api: api)
  }

  func requestPermission() {
    // No-op
  }

  func getBadgeCount() -> Int64 {
    let badgeCount = Int64(NSApplication.shared.dockTile.badgeLabel ?? "0") ?? 0
    return badgeCount
  }

  func setBadgeCount(count: Int64) {
    NSApplication.shared.dockTile.badgeLabel = String(count)
  }

  func clearBadgeCount() {
    if #available(OSX 10.14, *) {
      NSApplication.shared.dockTile.badgeLabel = nil
    } else {
      NSApplication.shared.dockTile.badgeLabel = "0"
    }
  }

  func showRedDot() {
    // Bounce the dock icon
    NSApplication.shared.requestUserAttention(.criticalRequest)
    // Show a red dot
    NSApplication.shared.dockTile.badgeLabel = "•"
  }
}
