#
# Be sure to run `pod lib lint LivenessProSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LivenessProSDK'
  s.version          = '1.3.0'
  s.summary          = 'LivenessProSDK is a liveness detection SDK for iOS of AdvanceAI.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
LivenessProSDK is a liveness detection SDK for iOS of AdvanceAI.
                       DESC

  s.homepage         = 'https://advance.ai'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'advance.ai' => 'advance.ai.mobile@advancegroup.com' }
  s.source           = { :http => 'https://prod-guardian-cv.oss-ap-southeast-5.aliyuncs.com/sdk/iOS-livenessPro-detection/1.3.0/iOS-LivenessPro-SDK-V1.3.0.tar.bz2' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  # s.source_files = 'LivenessProSDK/Classes/**/*'
  s.vendored_frameworks = ['LivenessProSDK/Frameworks/*.xcframework']
  # s.resource_bundles = {
  #   'LivenessProSDK' => ['LivenessProSDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
