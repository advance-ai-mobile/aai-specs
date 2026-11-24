#
# Binary distribution podspec for AAILivenessSDK (Standalone + Coexistence).
# Used by target=identifyRisk_product / solution_product and as the official release podspec.
#
Pod::Spec.new do |s|
  s.name             = 'AAILivenessSDK'
  s.version          = '4.4.0'
  s.summary          = 'Liveness detection core module.'
  s.description      = <<-DESC
  This is an AAI liveness detection SDK core module.
                       DESC
  s.homepage         = 'https://www.advance.ai'
  s.license          = { :type => 'example', :text => '' }
  s.authors          = 'advance.ai'
  s.ios.deployment_target = '10.0'
  s.source           = { :http => "https://github.com/advance-ai-mobile/AAILivenessSDK/releases/download/#{s.version}/AAILivenessSDK-V#{s.version}.tar.bz2", :type => :tbz }

  s.frameworks = 'AVFoundation', 'CoreMotion', 'CoreGraphics', 'CoreTelephony', 'SystemConfiguration', 'Accelerate', 'Metal', 'MetalKit', 'MetalPerformanceShaders'
  s.ios.library = 'c++', 'z', 'resolv.9'
  s.pod_target_xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'gnu++17',
    'OTHER_LDFLAGS' => '-ObjC',
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'x86_64',
  }

  s.default_subspecs = 'Core'

  s.subspec 'Core' do |cs|
    cs.dependency 'AAINetwork', '~> 1.1.0'
    cs.dependency 'AAICore', '~> 1.0.6'
  end

  s.subspec 'Standalone' do |st|
    st.dependency 'AAILivenessSDK/Core'
    st.vendored_frameworks = 'Frameworks/Standalone/AAILivenessSDK.xcframework'
  end

  s.subspec 'Coexistence' do |co|
    co.dependency 'AAILivenessSDK/Core'
    co.dependency 'AAICVCommonSDK/NcnnDynamic', '1.1.0'
    co.vendored_frameworks = 'Frameworks/Coexistence/AAILivenessSDK.xcframework'
    co.pod_target_xcconfig = {
      'OTHER_LDFLAGS' => '$(inherited) -framework "ncnn"',
    }
  end
end
