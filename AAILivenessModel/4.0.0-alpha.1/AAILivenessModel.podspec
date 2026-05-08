Pod::Spec.new do |s|
  s.name             = 'AAILivenessModel'
  s.version          = '4.0.0-alpha.1'
  s.summary          = 'iOS Liveness SDK model resouce files'
  s.description      = <<-DESC
  This framework is a wrapper for the model resource files used by the AAILivenessSDK. It is optional to include this framework.
  If you include this framework as a dependency, then the Liveness SDK will automatically use the model files contained within this framework.
  Otherwise, the SDK will automatically download the model files from the server when needed.
  Generally, if you want to minimize the SDK size, you can choose not to include this framework. However, to reduce runtime network requests, including this framework is recommended.
                       DESC
  s.homepage     = 'https://www.advance.ai'
  s.license      = { :type => 'example', :text => <<-LICENSE
                      
                    LICENSE
                    }
  s.authors      = 'advance.ai'
  s.ios.deployment_target = '10.0'
  s.source = { :http => 'https://prod-guardian-cv.oss-ap-southeast-5.aliyuncs.com/sdk/iOS-libraries/AAILivenessModel/4.0.0/AAILivenessModel-V4.0.0.tar.bz2', type: :tbz }
  
  s.vendored_frameworks = 'AAILivenessModel.xcframework'

end
