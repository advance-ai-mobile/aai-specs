#
# AAICoreSwift Binary Distribution Podspec
# This podspec is used for binary distribution via XCFramework
#

Pod::Spec.new do |s|
  s.name             = 'AAICoreSwift'
  s.version          = '1.0.0-alpha.2'
  s.summary          = 'A generic Swift-based core library for iOS development.'

  s.description      = <<-DESC
  AAICore-swift is a generic, business-agnostic core library that provides:
  - Networking utilities (LPNetworking)
  - Logging system (AAILogger)
  - AES encryption/decryption (AESCryptor)
  - Device information collection (IRDevice)
  - Common extensions and utilities
  
  This library uses configuration injection pattern to allow business layers
  to provide their own configurations without hardcoding business logic.
  
  This is a binary distribution. Source code is not included.
  DESC

  s.homepage         = 'https://www.advance.ai'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'advance.ai' => 'advance.ai.mobile@advancegroup.com' }
  
  # Binary distribution from OSS
  s.source           = { 
    :http => 'https://prod-guardian-cv.oss-ap-southeast-5.aliyuncs.com/sdk/iOS-libraries/AAICoreSwift/1.0.0-alpha.2/AAICoreSwift-V1.0.0-alpha.2.tar.bz2'
  }

  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'

  # XCFramework
  s.vendored_frameworks = 'Frameworks/AAICoreSwift.xcframework'

  # Libraries
  s.ios.library = 'c++', 'z'

  # Build settings
  s.pod_target_xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'gnu++17',
    'SWIFT_VERSION' => '5.0'
  }

end
