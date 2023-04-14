#if os(iOS)
  import Flutter
  import UIKit

#elseif os(macOS)
  import FlutterMacOS
  import Foundation

#endif

public class FlutterNativeBadgePlugin: NSObject, FlutterPlugin, FlutterNativeBadgeApi {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let api: FlutterNativeBadgePlugin = FlutterNativeBadgePlugin()

    // Workaround for https://github.com/flutter/flutter/issues/118103
    // TODO(Isaac): Remove this workaround when the issue is fixed.
    #if os(iOS)
      let messenger = registrar.messenger()
    #else
      let messenger = registrar.messenger
    #endif
    FlutterNativeBadgeApiSetup.setUp(binaryMessenger: messenger, api: api)
  }

  func getBadgeCount() -> Int64 {
    #if os(iOS)
      let badgeCount = Int64(UIApplication.shared.applicationIconBadgeNumber)
    #elseif os(macOS)
      let badgeCount = Int64(NSApplication.shared.dockTile.badgeLabel ?? "0") ?? 0
    #endif

    return badgeCount
  }

  func setBadgeCount(count: Int64) {
    #if os(iOS)
      UIApplication.shared.applicationIconBadgeNumber = Int(truncatingIfNeeded: count)
    #elseif os(macOS)
      NSApplication.shared.dockTile.badgeLabel = String(count)
    #endif
  }

  func resetBadgeCount() {
    #if os(iOS)
      UIApplication.shared.applicationIconBadgeNumber = 0
    #elseif os(macOS)
      if #available(OSX 10.14, *) {
        NSApplication.shared.dockTile.badgeLabel = nil
      } else {
        NSApplication.shared.dockTile.badgeLabel = "0"
      }
    #endif
  }

  func setBadgeRedDot() {
    #if os(iOS)
      UIApplication.shared.applicationIconBadgeNumber = -1
    #elseif os(macOS)
      NSApplication.shared.dockTile.badgeLabel = nil
      NSApplication.shared.dockTile.badgeLabel = "•"
    #endif
  }
}
