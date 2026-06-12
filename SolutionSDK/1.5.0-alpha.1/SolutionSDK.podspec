#
# SolutionSDK Binary Distribution Podspec
# This podspec is used for binary distribution via XCFramework + GitHub Release
#

Pod::Spec.new do |s|
  s.name             = 'SolutionSDK'
  s.version          = '1.5.0-alpha.1'
  s.summary          = 'Identity risk solution H5 module.'
  s.description      = 'Identity risk solution H5 module.'

  s.homepage         = 'https://www.advance.ai'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'advance.ai' => 'advance.ai.mobile@advancegroup.com' }
  s.source           = { :http => 'https://github.com/advance-ai-mobile/SolutionSDK/releases/download/1.5.0-alpha.1/SolutionSDK-V1.5.0-alpha.1.tar.bz2' }

  s.ios.deployment_target = '12.0'

  s.vendored_frameworks = ['Frameworks/*.xcframework']

  s.dependency 'AAICoreSwift', '~> 1.0.0-alpha'
  s.dependency 'AAIDataVisorSDK', '~> 0.1.9'
  s.dependency 'AAICore', '~> 1.0.3'

end
