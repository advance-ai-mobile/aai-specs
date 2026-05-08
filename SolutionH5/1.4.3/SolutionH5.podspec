#
# Be sure to run `pod lib lint LivenessProSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SolutionH5'
  s.version          = '1.4.3'
  s.summary          = 'Identity risk solution H5 module.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Identity risk solution with H5 module to provide risk assessment for identity verification scenarios.'

  s.homepage         = 'https://github.com/loong/SolutionH5'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'advance.ai' => 'advance.ai.mobile@advancegroup.com' }
  s.source           = { :http => 'https://prod-guardian-cv.oss-ap-southeast-5.aliyuncs.com/sdk/iOS-Solution-SDK/1.4.3/iOS-SolutionH5-V1.4.3.tar.bz2', type: :tbz }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.vendored_frameworks = ['SolutionH5/Frameworks/*.xcframework']
  s.dependency 'AAIDataVisorSDK', '~> 0.1.7'
  s.dependency 'AAICore', '~> 1.0.1'
end
