#
# Binary distribution podspec for AAICVCommonSDK.
# Used by target=identifyRisk_product / solution_product and as the official release podspec.
#
Pod::Spec.new do |s|
  s.name             = 'AAICVCommonSDK'
  s.version          = '1.1.0'
  s.summary          = 'Shared ncnn/json11/encryption/http prebuilt libraries for Guardian CV SDKs.'

  s.description      = 'Provides prebuilt third-party libraries (ncnn/json11/encryption/http) for Guardian CV SDKs. ncnn form subspecs: NcnnDynamic (dynamic ncnn.framework only — the Coexistence provider) and CVLibBundleLiveness / CVLibBundleIqa (per-product static libncnn.a + json11/encryption/http — the self-contained bundles).'

  s.homepage         = 'https://www.advance.ai'
  s.license          = { :type => 'example', :text => <<-LICENSE
                        LICENSE
                        }
  s.author           = { 'loong' => 'yulong.chen.tec@advancegroup.com' }
  s.source           = { :http => "https://github.com/advance-ai-mobile/AAICVCommonSDK/releases/download/#{s.version}/AAICVCommonSDK-V#{s.version}.tar.bz2", :type => :tbz }
  s.ios.deployment_target = '9.0'

  # Vendored xcframeworks are arm64-only (device + simulator). Exclude x86_64
  # simulator so CocoaPods lint/repo-push selects ios-arm64-simulator slices.
  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'x86_64',
    'GCC_SYMBOLS_PRIVATE_EXTERN' => 'NO',
  }

  # Base is the default subspec — minimal (just a placeholder header).
  # Prevents CocoaPods from auto-including other subspecs when one is explicitly requested.
  s.default_subspecs = 'Base'

  # Base third-party frameworks (no http, no ncnn).
  base_third_party_xcframeworks = [
    'Frameworks/json11.xcframework',
    'Frameworks/encryption.xcframework',
  ]

  # Third-party frameworks shared by all engine variants (no ncnn).
  third_party_xcframeworks = base_third_party_xcframeworks + [
    'Frameworks/http.xcframework',
  ]

  s.subspec 'Base' do |b|
    b.source_files = 'AAICVCommonSDK/AAICVCommonSDKBase.h'
  end

  # Dynamic ncnn only — the Coexistence provider.
  s.subspec 'NcnnDynamic' do |nd|
    nd.vendored_frameworks = ['Frameworks/Dynamic/ncnn.xcframework']
    nd.pod_target_xcconfig = {
      'OTHER_LDFLAGS' => '$(inherited) -framework "ncnn"',
    }
  end

  # Static library bundles — one per product.
  s.subspec 'CVLibBundleLiveness' do |cv|
    cv.vendored_frameworks = third_party_xcframeworks + ['Frameworks/Static/Liveness/ncnn.xcframework']
    cv.pod_target_xcconfig = {
      'OTHER_LDFLAGS[sdk=iphoneos*]' => '$(inherited) -l"ncnn" -L"${PODS_TARGET_SRCROOT}/Frameworks/Static/Liveness/ncnn.xcframework/ios-arm64"',
      'OTHER_LDFLAGS[sdk=iphonesimulator*]' => '$(inherited) -l"ncnn" -L"${PODS_TARGET_SRCROOT}/Frameworks/Static/Liveness/ncnn.xcframework/ios-arm64-simulator"',
    }
    cv.user_target_xcconfig = {
      'OTHER_LDFLAGS' => '$(inherited) -l"ncnn" -L"${PODS_XCFRAMEWORKS_BUILD_DIR}/AAICVCommonSDK/CVLibBundleLiveness"',
    }
  end

  s.subspec 'CVLibBundleIqa' do |cv|
    cv.vendored_frameworks = third_party_xcframeworks + ['Frameworks/Static/Iqa/ncnn.xcframework']
    cv.pod_target_xcconfig = {
      'OTHER_LDFLAGS[sdk=iphoneos*]' => '$(inherited) -l"ncnn" -L"${PODS_TARGET_SRCROOT}/Frameworks/Static/Iqa/ncnn.xcframework/ios-arm64"',
      'OTHER_LDFLAGS[sdk=iphonesimulator*]' => '$(inherited) -l"ncnn" -L"${PODS_TARGET_SRCROOT}/Frameworks/Static/Iqa/ncnn.xcframework/ios-arm64-simulator"',
    }
    cv.user_target_xcconfig = {
      'OTHER_LDFLAGS' => '$(inherited) -l"ncnn" -L"${PODS_XCFRAMEWORKS_BUILD_DIR}/AAICVCommonSDK/CVLibBundleIqa"',
    }
  end
end
