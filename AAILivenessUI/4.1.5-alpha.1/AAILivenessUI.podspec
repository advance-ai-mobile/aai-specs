Pod::Spec.new do |s|
  s.name             = 'AAILivenessUI'
  s.version          = '4.1.5-alpha.1'
  s.summary          = 'LivenessSDK UI module.'
  s.description      = <<-DESC
  This is a UI module, SDK UI is implemented in this module and it's open source.
                       DESC
  s.homepage     = 'https://www.advancegroup.com'
  s.license      = { :type => 'example', :text => <<-LICENSE
                      
                    LICENSE
                    }
  s.authors      = 'advance.ai'
  s.ios.deployment_target = '10.0'

  s.source = { :http => 'https://prod-guardian-cv.oss-ap-southeast-5.aliyuncs.com/sdk/iOS-liveness-UI/4.1.5-alpha.1/iOS-Liveness-UI-V4.1.5-alpha.1.tar.bz2', type: :tbz }

  s.resource_bundles = {
    'AAILivenessResources' => [
      'AAILivenessUI/Resource/AAIAudio.bundle', 
      'AAILivenessUI/Resource/AAIImgs.xcassets', 
      'AAILivenessUI/Resource/AAILanguageString.bundle', 
      'AAILivenessUI/Resource/PrivacyInfo.xcprivacy']
  }
  
  s.subspec 'Private' do |ss|
    ss.source_files = 'AAILivenessUI/Classes/Private/*'
  end

  s.subspec 'AAILiveness' do |ss|
    ss.source_files = 'AAILivenessUI/Classes/AAILiveness/*'
    ss.dependency 'AAILivenessUI/Private'
  end

  s.dependency 'AAILivenessSDK', '~> 4.1.5-alpha.1'
  
  s.pod_target_xcconfig = { 
    'OTHER_LDFLAGS' => '-ObjC',
    'DEFINES_MODULE' => 'YES',
  }
  
  s.frameworks = 'AVFoundation', 'CoreMotion', 'CoreGraphics', 'CoreTelephony', 'SystemConfiguration', 'Accelerate', 'Metal', 'MetalKit'
  s.ios.library = 'c++', 'z', 'resolv.9'
  
  s.dependency 'AAINetwork', '>= 1.0.4'
  s.dependency 'AAICore', '~> 1.0.3'

end
