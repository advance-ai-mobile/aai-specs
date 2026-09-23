#
# Binary distribution podspec for AAIGlobalIQASDK (dual-form release).
#
# Rendered by Script/build_iqa_sdk.py at release time; the placeholders
# 1.5.3-alpha.1 / :http => 'https://prod-guardian-cv.oss-ap-southeast-5.aliyuncs.com/sdk/iOS-global-IQA/1.5.3-alpha.1/iOS-GlobalIQA-SDK-V1.5.3-alpha.1.tar.bz2', type: :tbz / ~> 1.1.0 / ~> 1.0.2 /
# 1.1.0-alpha.2 are substituted with the values of that release.
#
# Forms — the host Podfile picks one; a bare `pod 'AAIGlobalIQASDK'` resolves to
# Core only (dependency container, no binary), mirroring AAILivenessSDK:
#   Core        — AAINetwork + AAICore only
#   Standalone  — self-contained binary: engine + static ncnn/json11/encryption baked in,
#                 no AAICVCommonSDK and no ncnn.framework required at runtime
#   Coexistence — binary sharing one dynamic ncnn.framework with the other Guardian SDKs;
#                 the engine is still baked in, ncnn is supplied by AAICVCommonSDK/NcnnOnly
#
Pod::Spec.new do |s|
  s.name             = 'AAIGlobalIQASDK'
  s.version          = '1.5.3-alpha.1'
  s.summary          = 'iOS AAIGlobalIQASDK.'
  s.description      = <<-DESC
  This SDK can scan card in real-time and assist in automatically capturing better quality card image.
                       DESC
  s.homepage     = 'https://advance.ai'
  s.license      = { :type => 'example', :text => '' }
  s.authors      = 'advance.ai'
  s.ios.deployment_target = '10.0'

  s.source = { :http => 'https://prod-guardian-cv.oss-ap-southeast-5.aliyuncs.com/sdk/iOS-global-IQA/1.5.3-alpha.1/iOS-GlobalIQA-SDK-V1.5.3-alpha.1.tar.bz2', type: :tbz }

  s.frameworks = 'AVFoundation', 'CoreGraphics', 'MediaPlayer', 'SystemConfiguration', 'Accelerate'
  s.ios.library = 'c++', 'z'

  # x86_64 simulator slice is not shipped (the engine/static libs only build for
  # arm64 + arm64-simulator); without this exclusion the [CP] copy phase skips the
  # xcframework and the consumer link fails with `ld: framework not found`.
  s.pod_target_xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'gnu++17',
    'OTHER_LDFLAGS' => '-ObjC',
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'x86_64',
  }

  s.default_subspecs = 'Core'

  s.subspec 'Core' do |cs|
    cs.dependency 'AAINetwork', '~> 1.1.0'
    cs.dependency 'AAICore', '~> 1.0.2'
  end

  s.subspec 'Standalone' do |st|
    st.dependency 'AAIGlobalIQASDK/Core'
    st.vendored_frameworks = 'Frameworks/Standalone/AAIGlobalIQASDK.xcframework'
  end

  s.subspec 'Coexistence' do |co|
    co.dependency 'AAIGlobalIQASDK/Core'
    co.dependency 'AAICVCommonSDK/NcnnOnly', '1.1.0-alpha.2'
    co.vendored_frameworks = 'Frameworks/Coexistence/AAIGlobalIQASDK.xcframework'
    co.pod_target_xcconfig = {
      'OTHER_LDFLAGS' => '$(inherited) -framework "ncnn"',
    }
  end
end
