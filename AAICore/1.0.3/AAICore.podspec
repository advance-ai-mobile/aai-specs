Pod::Spec.new do |s|
  s.name             = 'AAICore'
  s.version          = '1.0.3'
  s.summary          = 'A core utility library'
  s.description      = 'A core utility library that provides common functionalities for other libraries.'

  s.homepage         = 'https://www.advance.ai'
  s.license          = { :type => 'example', :text => <<-LICENSE
                          LICENSE
                       }
  s.authors          = "advance.ai"
  s.source           = { :git => 'https://github.com/advance-ai-mobile/AAICore.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.vendored_frameworks = 'Frameworks/AAICore.xcframework'

  s.pod_target_xcconfig = {
    'OTHER_LDFLAGS' => '-ObjC'
  }
  s.ios.library = 'c++', 'z', 'resolv.9'
end
