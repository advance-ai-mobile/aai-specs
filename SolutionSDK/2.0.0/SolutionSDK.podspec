#
# SolutionSDK Binary Distribution Podspec
# Used by target=solution_product and as the official release podspec.
# Core + optional HybridCore / HybridLiveness / HybridIQA vendored as separate xcframeworks.
#
Pod::Spec.new do |s|
  s.name             = 'SolutionSDK'
  s.version          = '2.0.0'
  s.summary          = 'Identity risk solution H5 module.'
  s.description      = 'Identity risk solution H5 module.'
  s.homepage         = 'https://www.advance.ai'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'advance.ai' => 'advance.ai.mobile@advancegroup.com' }
  s.source           = { :http => "https://github.com/advance-ai-mobile/SolutionSDK/releases/download/#{s.version}/SolutionSDK-V#{s.version}.tar.bz2" }
  s.ios.deployment_target = '12.0'
  s.default_subspecs = 'Core'

  s.pod_target_xcconfig = {
    'OTHER_LDFLAGS' => '-ObjC',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'x86_64',
  }

  s.subspec 'Core' do |core|
    core.vendored_frameworks = 'Frameworks/SolutionSDK.xcframework'
    core.dependency 'AAICoreSwift', '1.1.1'
    core.dependency 'AAIDataVisorSDK', '0.1.9'
    core.dependency 'AAICore', '1.0.6'
  end

  s.subspec 'HybridCore' do |hc|
    hc.vendored_frameworks = 'Frameworks/SolutionHybridCore.xcframework'
    hc.dependency 'SolutionSDK/Core'
  end

  s.subspec 'HybridLiveness' do |hybrid|
    hybrid.vendored_frameworks = 'Frameworks/SolutionHybridLiveness.xcframework'
    hybrid.dependency 'SolutionSDK/HybridCore'
    hybrid.dependency 'AAILivenessSDK/Coexistence', '4.4.0'
  end

  s.subspec 'HybridIQA' do |hybrid|
    hybrid.vendored_frameworks = 'Frameworks/SolutionHybridIQA.xcframework'
    hybrid.dependency 'SolutionSDK/HybridCore'
    hybrid.dependency 'AAIGlobalIQASDK/Coexistence', '1.5.3'
  end
end
