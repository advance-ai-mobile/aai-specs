
Pod::Spec.new do |s|
  s.name             = 'AAIGlobalIQASDK'
  s.version          = '1.5.0'
  s.summary          = 'iOS AAIGlobalIQASDK.'
  s.description      = <<-DESC
  This SDK can scan card in real-time and assist in automatically capturing better quality card image.
                       DESC
  s.homepage     = 'https://advance.ai'
  s.license      = { :type => 'example', :text => <<-LICENSE
                      
                    LICENSE
                    }
  s.authors      = 'advance.ai'
  s.ios.deployment_target = '10.0'

  s.source = { :http => 'https://prod-guardian-cv.oss-ap-southeast-5.aliyuncs.com/sdk/iOS-global-IQA/1.5.0/iOS-GlobalIQA-SDK-V1.5.0.tar.bz2', type: :tbz }
  s.vendored_frameworks = 'AAIGlobalIQASDK.xcframework'
  
  
  s.frameworks = 'AVFoundation', 'CoreGraphics', 'MediaPlayer', 'SystemConfiguration', 'Accelerate'
  s.ios.library = 'c++', 'z'
  
  s.dependency 'AAINetwork', '~> 1.0.4'
  s.dependency 'AAICore', '~> 1.0.1'
end
