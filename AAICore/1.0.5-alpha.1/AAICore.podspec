Pod::Spec.new do |s|
  s.name             = 'AAICore'
  s.version          = '1.0.5-alpha.1'
  s.summary          = 'A core utility library that provides common functionalities for other libraries.'
  s.homepage         = 'https://www.advance.ai'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'advance.ai' => 'advance.ai.mobile@gmail.com' }
  s.source           = { :http => 'https://github.com/advance-ai-mobile/AAICore/releases/download/1.0.5-alpha.1/AAICore-V1.0.5-alpha.1.tar.bz2', :type => :tbz }
  s.ios.deployment_target = '10.0'
  s.vendored_frameworks = 'AAICore.xcframework'
  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }
  s.ios.library = 'c++', 'z', 'resolv.9'
end
