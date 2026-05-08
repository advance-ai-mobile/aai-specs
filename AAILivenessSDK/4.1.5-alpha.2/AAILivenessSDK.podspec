Pod::Spec.new do |s|
  s.name             = 'AAILivenessSDK'
  s.version          = '4.1.5-alpha.2'
  s.summary          = 'Liveness detection core module.'
  s.description      = <<-DESC
  This is a AAI liveness detection SDK core module.
                       DESC
  s.homepage     = 'https://www.advance.ai'
  s.license      = { :type => 'example', :text => <<-LICENSE
                      
                    LICENSE
                    }
  s.authors      = 'advance.ai'
  s.ios.deployment_target = '10.0'
  s.source = { :http => 'https://prod-guardian-cv.oss-ap-southeast-5.aliyuncs.com/sdk/iOS-liveness-detection/4.1.5-alpha.2/AAILivenessSDK-V4.1.5-alpha.2.tar.bz2', type: :tbz }
  
  s.vendored_frameworks = 'AAILivenessSDK.xcframework'
  s.frameworks = 'AVFoundation', 'CoreMotion', 'CoreGraphics', 'CoreTelephony', 'SystemConfiguration', 'Accelerate', 'Metal', 'MetalKit'
  s.ios.library = 'c++', 'z', 'resolv.9'

  s.pod_target_xcconfig = {
    'OTHER_LDFLAGS' => '-ObjC'
  }

  s.dependency 'AAINetwork', '~> 1.1.0'
  s.dependency 'AAICore', '~> 1.0.2'
end
