#
# Be sure to run `pod lib lint AAICVCommonSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html#

Pod::Spec.new do |s|
  s.name             = 'AAICVCommonSDK'
  s.version          = '1.1.0-alpha.3'
  s.summary          = 'Shared guardian-cv-mobile engine source and ncnn/json11/encryption/http libraries for Guardian CV SDKs.'

  s.description      = 'Provides third-party libraries (ncnn/json11/encryption/http) and optional engine source compilation. ncnn form subspecs: NcnnDynamic (dynamic ncnn.framework only — the Coexistence provider) and CVLibBundleLiveness / CVLibBundleIqa (per-product static libncnn.a + json11/encryption/http — the self-contained bundles). Engine source lives in EngineCore/EngineLiveness/EngineIqa.'

  s.homepage         = 'https://repo.advai.net/guardian/frontend-web/mobile/OneStop-iOS.git'
  s.license      = { :type => 'example', :text => <<-LICENSE
                    LICENSE
                    }
  s.author           = { 'loong' => 'yulong.chen.tec@advancegroup.com' }
  s.source           = { :http => 'https://prod-guardian-cv.oss-ap-southeast-5.aliyuncs.com/sdk/iOS-libraries/AAICVCommonSDK/1.1.0-alpha.3/AAICVCommonSDK-V1.1.0-alpha.3.tar.bz2', type: :tbz }
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
  # Engine xcframework already embeds json11/encryption/http statically, so supplying ncnn
  # alone avoids duplicate vendored libs. Name says both things: the *form* (dynamic) and
  # the *scope* (only ncnn). The rename from the old two-name scheme is recorded in
  # specs/2026-09-28-ncnn-subspec-rename.md.
  #
  # The subspec owns the link flag for the *pod target itself*: EngineCore/EngineIqa/
  # EngineLiveness compile engine sources that call ncnn, and CocoaPods does not add
  # `-framework ncnn` for the pod's own vendored framework — without this the
  # AAICVCommonSDK target links with undefined ncnn symbols.
  s.subspec 'NcnnDynamic' do |nd|
    nd.vendored_frameworks = ['Frameworks/Dynamic/ncnn.xcframework']
    nd.pod_target_xcconfig = {
      'OTHER_LDFLAGS' => '$(inherited) -framework "ncnn"',
    }
  end

  # Static library bundles — for customer Standalone (smallest binary, self-contained), one per product.
  # Each carries more than ncnn, hence "bundle": a product-specific static libncnn.a + json11/encryption/http.
  # The ncnn build is trimmed to that product's layers (scripts/cmake/<product>.cmake in guardian-cv-mobile),
  # so a bundle must only be paired with its own Engine subspec:
  #   CVLibBundleLiveness → EngineLiveness,  CVLibBundleIqa → EngineIqa.
  # Built with NCNN_SHARED_LIB=OFF; stored in Frameworks/Static/<Product>/ (see specs/2026-10-15-cvlibbundle-split.md).
  # NOTE: each slice contains a plain static library `libncnn.a` (NOT a static .framework), so it must be
  # linked with `-l"ncnn"`, and the slice directory has to be on the search path: the `-L` flag lives in
  # OTHER_LDFLAGS on purpose — a LIBRARY_SEARCH_PATHS entry here collides with EngineCore's own
  # LIBRARY_SEARCH_PATHS (CocoaPods cannot merge that singular key across two subspecs of one pod).
  # The -L is split per sdk: with both slice dirs on the path the linker picks the first match (device) for a simulator build.
  # Consumer side: user_target_xcconfig reaches a *host* target (an app embedding the engine + static ncnn),
  # but NOT another pod target — CocoaPods does not forward a static-library slice's link flag from one
  # pod to the pod that consumes it. A pod that bakes static ncnn therefore has to state -l"ncnn" + -L itself;
  # Script/check_ncnn_form.py enforces that only a Standalone-form pod does so.
  # The trailing path segment of the user-side -L is the subspec name — CocoaPods materialises a subspec's
  # vendored xcframework under XCFrameworkIntermediates/<Pod>/<Subspec>, so it has to follow the name.
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
