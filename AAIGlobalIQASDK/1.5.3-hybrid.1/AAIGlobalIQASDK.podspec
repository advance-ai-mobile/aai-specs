#
# Binary distribution podspec for AAIGlobalIQASDK (Standalone + Coexistence).
# Used by target=identifyRisk_product / solution_product and as the official release podspec.
#
Pod::Spec.new do |s|
  s.name             = 'AAIGlobalIQASDK'
  s.version          = '1.5.3-hybrid.1'
  s.summary          = 'iOS AAIGlobalIQASDK.'
  s.description      = <<-DESC
  This SDK can scan card in real-time and assist in automatically capturing better quality card image.
                       DESC
  s.homepage         = 'https://advance.ai'
  s.license          = { :type => 'example', :text => '' }
  s.authors          = 'advance.ai'
  s.ios.deployment_target = '10.0'
  s.source           = { :http => "https://github.com/advance-ai-mobile/AAIGlobalIQASDK/releases/download/#{s.version}/AAIGlobalIQASDK-V#{s.version}.tar.bz2", :type => :tbz }

  s.frameworks = 'AVFoundation', 'CoreGraphics', 'MediaPlayer', 'SystemConfiguration', 'Accelerate', 'CoreMotion'
  s.ios.library = 'c++', 'z'

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
    co.dependency 'AAICVCommonSDK/NcnnDynamic', '1.1.0'
    co.vendored_frameworks = 'Frameworks/Coexistence/AAIGlobalIQASDK.xcframework'
    co.pod_target_xcconfig = {
      'OTHER_LDFLAGS' => '$(inherited) -framework "ncnn"',
    }
  end
end
