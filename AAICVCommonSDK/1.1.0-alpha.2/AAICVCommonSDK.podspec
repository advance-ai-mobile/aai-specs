#
# Be sure to run `pod lib lint AAICVCommonSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html#

Pod::Spec.new do |s|
  s.name             = 'AAICVCommonSDK'
  s.version          = '1.1.0-alpha.2'
  s.summary          = 'Shared guardian-cv-mobile engine source and ncnn/json11/encryption/http libraries for Guardian CV SDKs.'

  s.description      = 'Provides third-party libraries (ncnn/json11/encryption/http) and optional engine source compilation. Subspecs: NcnnDynamic/NcnnStatic/NcnnOnly (ncnn form for customer integration), EngineSource (common+models source for internal debugging).'

  s.homepage         = 'https://repo.advai.net/guardian/frontend-web/mobile/OneStop-iOS.git'
  s.license      = { :type => 'example', :text => <<-LICENSE
                    LICENSE
                    }
  s.author           = { 'loong' => 'yulong.chen.tec@advancegroup.com' }
  s.source           = { :http => 'https://prod-guardian-cv.oss-ap-southeast-5.aliyuncs.com/sdk/iOS-libraries/AAICVCommonSDK/1.1.0-alpha.2/AAICVCommonSDK-V1.1.0-alpha.2.tar.bz2', type: :tbz }
  s.ios.deployment_target = '9.0'

  # Vendored xcframeworks are arm64-only (device + simulator). Exclude x86_64
  # simulator so CocoaPods lint/repo-push selects ios-arm64-simulator slices.
  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'x86_64',
  }

  # Base is the default subspec — minimal (just a placeholder header).
  # Prevents CocoaPods from auto-including other subspecs when one is explicitly requested.
  s.default_subspecs = 'Base'

  # Third-party frameworks shared by all engine variants (no ncnn).
  third_party_xcframeworks = [
    'Frameworks/json11.xcframework',
    'Frameworks/encryption.xcframework',
    'Frameworks/http.xcframework',
  ]

  s.subspec 'Base' do |b|
    b.source_files = 'AAICVCommonSDK/AAICVCommonSDKBase.h'
  end

  # ncnn dynamic framework — for customer Coexistence (shared ncnn between SDKs).
  s.subspec 'NcnnDynamic' do |nd|
    nd.vendored_frameworks = third_party_xcframeworks + ['Frameworks/ncnn.xcframework']
  end

  # Dynamic ncnn only — for Liveness/IQA Coexistence when engine xcframework already
  # embeds json11/encryption/http statically (avoids duplicate vendored libs).
  s.subspec 'NcnnOnly' do |no|
    no.vendored_frameworks = ['Frameworks/ncnn.xcframework']
  end

  # ncnn static library — for customer Standalone (smallest binary, self-contained).
  # Built with NCNN_SHARED_LIB=OFF; stored in Frameworks/Static/ to avoid name collision with dynamic version.
  s.subspec 'NcnnStatic' do |ns|
    ns.vendored_frameworks = third_party_xcframeworks + ['Frameworks/Static/ncnn.xcframework']
  end


end
