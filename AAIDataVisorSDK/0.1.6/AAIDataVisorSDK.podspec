#
# Be sure to run `pod lib lint AAIDataVisor.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AAIDataVisorSDK'
  s.version          = '0.1.6'
  s.summary          = 'The device info security kit'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'The device info an AAIDataVisor. For anti-fraud and security protection, AAIDataVisorSDK provides device information capabilities.'

  s.homepage         = 'https://www.advancegroup.com.cn/'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'advancer' => 'advance.ai.mobile@gmail.com' }
  s.source           = { :http => 'https://prod-guardian-cv.oss-accelerate.aliyuncs.com/sdk/iOS-AAIDataVisor-SDK/0.1.6/iOS-AAIDataVisorSDK-V0.1.6.tar.bz2', :type => :tbz }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.vendored_frameworks = 'Frameworks/AAIDataVisor.xcframework'
end 