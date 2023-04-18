#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_native_badge_foundation.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
    s.name             = 'flutter_native_badge_foundation'
    s.version          = '1.0.3'
    s.summary          = 'iOS and macOS implementation of the flutter_native_badge plugin.'
    s.description      = <<-DESC
    Wraps the native APIs for iOS and macOS to set the badge count on the app icon.
                         DESC
    s.homepage         = 'https://github.com/isaacadariku/flutter_native_badge/tree/main/flutter_native_badge_foundation'
    s.license          = { :type => 'MIT', :file => '../LICENSE' }
    s.author           = { 'Isaac Adariku' => 'isaacadariku05@gmail.com' }
    s.source           = { :http => 'https://github.com/isaacadariku/flutter_native_badge/tree/main/flutter_native_badge_foundation' }
    s.source_files = 'Classes/**/*'
    s.osx.dependency 'FlutterMacOS'
    s.osx.deployment_target = '10.11'

    s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
    s.xcconfig = {
      'LIBRARY_SEARCH_PATHS' => '$(TOOLCHAIN_DIR)/usr/lib/swift/$(PLATFORM_NAME)/ $(SDKROOT)/usr/lib/swift',
      'LD_RUNPATH_SEARCH_PATHS' => '/usr/lib/swift',
    }
    s.swift_version = '5.0'
  end
  