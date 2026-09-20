#
# Be sure to run `pod lib lint AAILivenessSDK1.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html#

Pod::Spec.new do |s|
  s.name             = 'AAILivenessSDK'
  s.version          = '4.3.1-alpha.1'
  s.summary          = 'AAILivenessSDK — liveness detection.'

  s.description      = <<-DESC
Liveness detection SDK with engine compiled from source into the binary.
Two customer-facing variants: Standalone (ncnn static, single-SDK) and
Coexistence (ncnn dynamic, Liveness+IQA shared). Internal: EngineSource
(source debug) and EngineBinary (liball, Solution SDK coexistence debug).
                       DESC

  s.homepage         = 'https://github.com/loong/AAILivenessSDK1'
  s.license      = { :type => 'example', :text => <<-LICENSE
                    LICENSE
                    }
  s.author           = { 'loong' => 'yulong.chen@advancegroup.com' }
  s.source           = { :http => 'https://prod-guardian-cv.oss-ap-southeast-5.aliyuncs.com/sdk/iOS-liveness-detection/4.3.1-alpha.1/AAILivenessSDK-V4.3.1-alpha.1.tar.bz2', type: :tbz }

  s.ios.deployment_target = '10.0'

  # ---- subspec 矩阵 ----
  #   Core          — 纯依赖容器（无 source_files），避免 source/binary 冲突
  #   EngineSource  — 内部调试：shell 源码 + 引擎源码 + ncnn dynamic
  #   EngineBinary  — 内部 Solution SDK 共存调试：shell 源码 + liball + ncnn dynamic
  #   Standalone    — 客户单独集成：预编译 xcframework（引擎已编译进二进制）+ ncnn static
  #   Coexistence   — 客户同时集成：预编译 xcframework + ncnn dynamic（外部共享）
  #
  # default_subspecs = 'Core'：裸名只拿依赖壳，用户必须显式选 engine subspec。
  s.default_subspecs = 'Core'

  # 可继承属性，对所有变体生效
  s.frameworks = 'Metal', 'MetalKit', 'MetalPerformanceShaders'
  s.ios.library = 'c++', 'z', 'resolv.9'
  s.pod_target_xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'gnu++17',
    'OTHER_LDFLAGS' => '-ObjC',
    'DEFINES_MODULE' => 'YES',
    # ncnn/json11/encryption/http (via AAICVCommonSDK) are arm64-only on simulator.
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'x86_64',
  }

  # ---- 共享：业务壳源码（EngineSource / EngineBinary 使用）----
  shell_source_files = [
    'AAILivenessSDK/Classes/main/**/*',
    'AAILivenessSDK/Classes/DVSDKEvent/**/*',
    'AAILivenessSDK/Classes/main/Liveness/**/*',
    'AAILivenessSDK/Classes/pu_headers/**/*',
  ]
  shell_exclude_files = [
    'AAILivenessSDK/Classes/main/Native/cpp/encryption/encryptutil.*',
  ]
  shell_public_headers = 'AAILivenessSDK/Classes/main/pu_headers/*.h'
  shell_resources = 'AAILivenessSDK/PrivacyInfo.xcprivacy'
  shell_prefix_header = 'AAILivenessSDK/Classes/main/Liveness/AAIObfuscatePrefixHeader.pch'
  # 源码编译时的 C++ 头搜索路径
  shell_user_header_search_paths = '"${PODS_TARGET_SRCROOT}/AAILivenessSDK/Classes/main/Native/cpp/**"'

  # ---- Core：纯依赖容器 ----
  s.subspec 'Core' do |cs|
    cs.dependency 'AAINetwork', '~> 1.1.0'
    cs.dependency 'AAICore', '~> 1.0.6'
    # AAICVCommonSDK 不挂 Core：ncnn 形态由各 engine subspec 显式选择，
    # 避免 Standalone 同时拉入 NcnnDynamic（Core 继承）和 NcnnStatic（显式）冲突。
  end


  # ---- Standalone：客户单独集成（预编译 xcframework + ncnn static）----
  # 引擎已从源码编译进 AAILivenessSDK.xcframework，不依赖 liball。
  # ncnn 以静态库链接，SDK 自包含，包体积最小。
  s.subspec 'Standalone' do |st|
    st.dependency 'AAILivenessSDK/Core'
    st.dependency 'AAICVCommonSDK/NcnnStatic', '1.1.0-alpha.1'
    st.vendored_frameworks = 'Frameworks/AAILivenessSDK.xcframework'
    st.pod_target_xcconfig = {
      # ncnn static: -lncnn resolves symbols from libncnn.a at app link time.
      # No header search paths needed — engine is pre-compiled, ncnn headers
      # are only needed at xcframework build time, not at customer integration.
      'OTHER_LDFLAGS' => '$(inherited) -l"ncnn"',
      'LIBRARY_SEARCH_PATHS[sdk=iphoneos*]' => '"${PODS_ROOT}/AAICVCommonSDK/Frameworks/Static/ncnn.xcframework/ios-arm64"',
      'LIBRARY_SEARCH_PATHS[sdk=iphonesimulator*]' => '"${PODS_ROOT}/AAICVCommonSDK/Frameworks/Static/ncnn.xcframework/ios-arm64-simulator"',
    }
  end

  # ---- Coexistence：客户同时集成（预编译 xcframework + ncnn dynamic）----
  # 引擎已从源码编译进 AAILivenessSDK.xcframework，不依赖 liball。
  # ncnn 以动态框架提供，Liveness+IQA 共享一份。
  s.subspec 'Coexistence' do |co|
    co.dependency 'AAILivenessSDK/Core'
    co.dependency 'AAICVCommonSDK/NcnnDynamic', '1.1.0-alpha.1'
    co.vendored_frameworks = 'Frameworks/AAILivenessSDK.xcframework'
    # ncnn dynamic: -framework ncnn resolves symbols from ncnn.framework at load time.
    # No header search paths needed — engine is pre-compiled.
  end

end
