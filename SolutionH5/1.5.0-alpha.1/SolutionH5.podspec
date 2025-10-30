#
# Be sure to run `pod lib lint LivenessProSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SolutionH5'
  s.version          = '1.5.0-alpha.1'
  s.summary          = 'Identity risk solution H5 module.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Identity risk solution H5 module.'

  s.homepage         = 'https://www.advance.ai'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'advance.ai' => 'advance.ai.mobile@advancegroup.com' }
  s.source           = { :http => 'https://prod-guardian-cv.oss-ap-southeast-5.aliyuncs.com/sdk/iOS-Solution-SDK/1.5.0-alpha.1/iOS-SolutionH5-V1.5.0-alpha.1.tar.bz2' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  # s.source_files = 'SolutionH5/Classes/**/*'
  s.vendored_frameworks = ['SolutionH5/Frameworks/*.xcframework']
  # s.resource_bundles = {
  #   'LivenessProSDK' => ['SolutionSDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
