Pod::Spec.new do |s|
  s.name             = 'AAILivenessUI'
  s.version          = '4.1.3'
  s.summary          = 'LivenessSDK UI module.'
  s.description      = <<-DESC
  This is a UI module, SDK UI is implemented in this module and it's open source.
                       DESC
  s.homepage     = 'https://www.advance.ai'
  s.license      = { :type => 'example', :text => <<-LICENSE
                      
                    LICENSE
                    }
  s.authors      = 'advance.ai'
  s.ios.deployment_target = '10.0'

  s.source = { :http => 'https://prod-guardian-cv.oss-ap-southeast-5.aliyuncs.com/sdk/iOS-liveness-detection/4.1.3/iOS-Liveness-SDK-V4.1.3.tar.bz2', type: :tbz }

  s.resource_bundles = {
    'AAILivenessResources' => [
      'AAILivenessSDK/AAILivenessUI/Resource/AAIAudio.bundle', 
      'AAILivenessSDK/AAILivenessUI/Resource/AAIImgs.xcassets', 
      'AAILivenessSDK/AAILivenessUI/Resource/AAILanguageString.bundle', 
      'AAILivenessSDK/AAILivenessUI/Resource/PrivacyInfo.xcprivacy']
  }
  
  s.subspec 'Core' do |ss|
    ss.vendored_frameworks = 'AAILivenessSDK/AAILivenessSDK.xcframework'
  end

  s.subspec 'Private' do |ss|
    ss.source_files = 'AAILivenessSDK/AAILivenessUI/Classes/Private/*'
    ss.dependency 'AAILivenessUI/Core'
  end

  s.subspec 'AAILiveness' do |ss|
    ss.source_files = 'AAILivenessSDK/AAILivenessUI/Classes/AAILiveness/*'
    ss.dependency 'AAILivenessUI/Private'
  end
  
  s.pod_target_xcconfig = { 
    'OTHER_LDFLAGS' => '-ObjC',
    'DEFINES_MODULE' => 'YES',
  }
  
  s.frameworks = 'AVFoundation', 'CoreMotion', 'CoreGraphics', 'CoreTelephony', 'SystemConfiguration', 'Accelerate', 'Metal', 'MetalKit'
  s.ios.library = 'c++', 'z', 'resolv.9'
  
  s.dependency 'AAINetwork', '>= 1.0.4'
  s.dependency 'AAICore', '~> 1.0.2'

end
