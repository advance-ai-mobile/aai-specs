#
# SolutionSDK Binary Distribution Podspec (Core + optional Hybrid)
#

Pod::Spec.new do |s|
  s.name             = 'SolutionSDK'
  s.version          = '2.0.0-alpha.1'
  s.summary          = 'Identity risk solution H5 module.'
  s.description      = 'Identity risk solution H5 module.'
  s.homepage         = 'https://www.advance.ai'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'advance.ai' => 'advance.ai.mobile@advancegroup.com' }
  s.source           = { :http => 'https://github.com/advance-ai-mobile/SolutionSDK/releases/download/2.0.0-alpha.1/SolutionSDK-V2.0.0-alpha.1.tar.bz2' }
  s.ios.deployment_target = '12.0'
  s.default_subspecs = 'Core'

  s.subspec 'Core' do |core|
    core.vendored_frameworks = 'Frameworks/SolutionSDK.xcframework'
    core.dependency 'AAICoreSwift', '1.1.1-alpha.1'
    core.dependency 'AAIDataVisorSDK', '0.1.9'
    core.dependency 'AAICore', '1.0.6'
  end

  s.subspec 'HybridLiveness' do |hybrid|
    hybrid.vendored_frameworks = 'Frameworks/SolutionHybridLiveness.xcframework'
    hybrid.dependency 'SolutionSDK/Core'
    hybrid.dependency 'AAILivenessSDK', '4.4.0-alpha.1'
  end

  s.subspec 'HybridIQA' do |hybrid|
    hybrid.vendored_frameworks = 'Frameworks/SolutionHybridIQA.xcframework'
    hybrid.dependency 'SolutionSDK/Core'
    hybrid.dependency 'AAIGlobalIQASDK', '1.5.3-alpha.2'
  end
end
