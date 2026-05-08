#
# Be sure to run `pod lib lint AAILivenessSDK1.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AAIGlobalIQAUI'
  s.version          = '1.5.0'
  s.summary          = 'The default UI for AAIGlobalIQASDK'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
   This is the default UI for AAIGlobalIQASDK. You can use it to quickly build a UI for AAIGlobalIQASDK.
                       DESC

  s.homepage         = 'https://advance.ai'
  s.license      = { :type => 'example', :text => <<-LICENSE
                      
                    LICENSE
                    }
  s.author           = 'advance.ai'
  s.source           = { :http => 'https://prod-guardian-cv.oss-ap-southeast-5.aliyuncs.com/sdk/iOS-global-IQA/1.5.0/iOS-GlobalIQA-UI-V1.5.0.tar.bz2', type: :tbz }

  s.ios.deployment_target = '10.0'

  s.source_files = ['Classes/**/*']
  s.public_header_files = ['Classes/Public/*.h']
  s.resource_bundles = {
    'Assets' => ['Resources/AAIIQAAudio.bundle','Resources/AAIIQALanguageString.bundle','Resources/AAIIQAImgs.xcassets', 'Resources/PrivacyInfo.xcprivacy'],
  }
  s.pod_target_xcconfig = { 
    'OTHER_LDFLAGS' => '-ObjC',
    'DEFINES_MODULE' => 'YES',
  }
  
  s.dependency 'AAIGlobalIQASDK', '1.5.0'
end
