Pod::Spec.new do |s|
  s.name             = 'AAIDataVisorSDK'
  s.version          = '0.1.10-alpha.1'
  s.summary          = 'The device info an AAIDataVisor. For anti-fraud and security protection.'
  s.description      = 'The device info an AAIDataVisor. For anti-fraud and security protection, AAIDataVisorSDK provides device information capabilities.'
  s.homepage         = 'https://advance.ai'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'advance.ai' => 'advance.ai.mobile@gmail.com' }
  s.source           = { :http => 'https://github.com/advance-ai-mobile/AAIDataVisorSDK/releases/download/0.1.10-alpha.1/AAIDataVisorSDK-V0.1.10-alpha.1.tar.bz2', :type => :tbz }
  s.ios.deployment_target = '10.0'
  s.vendored_frameworks = 'AAIDataVisor.xcframework'
end
