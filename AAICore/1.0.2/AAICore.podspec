#
# Be sure to run `pod lib lint AAINetwork.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'AAICore'
    s.version          = '1.0.2'
    s.summary          = 'A core utility library'
    s.description      = 'A core utility library that provides common functionalities for other libraries.'
  
    s.homepage         = 'https://www.advance.ai'
    s.license          = { :type => 'example', :text => <<-LICENSE
                            LICENSE
                         }
    s.authors          = "advance.ai"
    s.source           = { :http => 'https://prod-guardian-cv.oss-ap-southeast-5.aliyuncs.com/sdk/iOS-libraries/AAICore/1.0.2/AAICore-V1.0.2.tar.bz2', :type => :tbz }
  
    s.ios.deployment_target = '10.0'
    s.vendored_frameworks = 'AAICore.xcframework'
    
    s.pod_target_xcconfig = {
      'OTHER_LDFLAGS' => '-ObjC'
    }
    s.ios.library = 'c++', 'z', 'resolv.9'
  end
  