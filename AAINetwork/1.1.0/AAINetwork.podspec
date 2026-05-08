
Pod::Spec.new do |s|
  s.name             = 'AAINetwork'
  s.version          = '1.1.0'
  s.summary          = 'A base network library that many AAI SDKs rely on.'
  s.description      = 'A base network library that many AAI SDKs rely on.'


  s.homepage         = 'https://www.advancegroup.com'
  s.license      = { :type => 'example', :text => <<-LICENSE
                      
                    LICENSE
                    }
  s.author           = { 'advancer' => 'advance.ai.mobile@gmail.com' }
  s.source           = { :http => 'https://prod-guardian-cv.oss-ap-southeast-5.aliyuncs.com/sdk/iOS-libraries/AAINetwork/AAINetwork-V1.1.0.tar.bz2', type: :tbz }

  s.ios.deployment_target = '10.0'
  s.vendored_frameworks = 'AAINetwork.xcframework'
  s.ios.library = 'c++', 'z'
end
