import FlutterMacOS
import Foundation

public class FlutterNativeBadgePlugin: NSObject, FlutterPlugin, FlutterNativeBadgeApi {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let api: FlutterNativeBadgePlugin = FlutterNativeBadgePlugin()
    let messenger = registrar.messenger

    FlutterNativeBadgeApiSetup.setUp(binaryMessenger: messenger, api: api)
  }

  func requestPermission(completion: @escaping (Result<Void, Error>) -> Void) {
    // No permission needed on macOS
    completion(.success(()))
  }

  func getBadgeCount() -> Int64 {
    let badgeCount = Int64(NSApplication.shared.dockTile.badgeLabel ?? "0") ?? 0
    return badgeCount
  }

  func setBadgeCount(count: Int64) {
    // A nil label hides the badge; "0" would be shown as a literal zero.
    NSApplication.shared.dockTile.badgeLabel = count > 0 ? String(count) : nil
  }

  func clearBadgeCount() {
    NSApplication.shared.dockTile.badgeLabel = nil
  }

  func showRedDot() {
    // Bounce the dock icon
    NSApplication.shared.requestUserAttention(.criticalRequest)
    // Show a red dot
    NSApplication.shared.dockTile.badgeLabel = "•"
  }
}
