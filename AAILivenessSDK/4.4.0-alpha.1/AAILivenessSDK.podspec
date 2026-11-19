#
# Be sure to run `pod lib lint AAILivenessSDK1.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html#

Pod::Spec.new do |s|
  s.name             = 'AAILivenessSDK'
  s.version          = '4.4.0-alpha.1'
  s.summary          = 'AAILivenessSDK — liveness detection.'

  s.description      = <<-DESC
Liveness detection SDK. Customer subspecs Standalone and Coexistence ship prebuilt
AAILivenessSDK.xcframework (shell + full guardian-cv-mobile engine C++ + static
json11/encryption/http). Standalone also embeds static ncnn; Coexistence loads
dynamic ncnn via AAICVCommonSDK/NcnnDynamic. Internal EngineSource for monorepo debug.
                       DESC

  s.homepage         = 'https://github.com/loong/AAILivenessSDK1'
  s.license      = { :type => 'example', :text => <<-LICENSE
                    LICENSE
                    }
  s.author           = { 'loong' => 'yulong.chen@advancegroup.com' }
  s.source           = { :http => 'https://prod-guardian-cv.oss-ap-southeast-5.aliyuncs.com/sdk/iOS-liveness-detection/4.4.0-alpha.1/AAILivenessSDK-V4.4.0-alpha.1.tar.bz2', type: :tbz }

  s.ios.deployment_target = '10.0'

  # ---- subspec 矩阵 ----
  #   Core              — 纯依赖容器
  #   EngineSource      — monorepo 联调：liveness/ 源码 + AAICVCommonSDK/EngineSource
  #   Standalone        — 客户单点：Frameworks/Standalone/*.xcframework，无 AAICVCommonSDK
  #   Coexistence       — 客户共存：Frameworks/Coexistence/*.xcframework + NcnnDynamic
  s.default_subspecs = 'Core'

  s.frameworks = 'Metal', 'MetalKit', 'MetalPerformanceShaders'
  s.ios.library = 'c++', 'z', 'resolv.9'
  s.pod_target_xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'gnu++17',
    'OTHER_LDFLAGS' => '-ObjC',
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'x86_64',
  }

  shell_source_files = [
    'AAILivenessSDK/Classes/main/**/*.{h,m,mm,cpp,hpp,c,swift,metal}',
    'AAILivenessSDK/Classes/DVSDKEvent/**/*.{h,m,mm,cpp,hpp,c,swift}',
  ]
  shell_exclude_files = [
    'AAILivenessSDK/Classes/main/Native/cpp/encryption/encryptutil.*',
  ]
  shell_public_headers = 'AAILivenessSDK/Classes/main/pu_headers/*.h'
  shell_resources = 'AAILivenessSDK/PrivacyInfo.xcprivacy'
  shell_prefix_header = 'AAILivenessSDK/Classes/main/Liveness/AAIObfuscatePrefixHeader.pch'
  shell_user_header_search_paths = '"${PODS_TARGET_SRCROOT}/AAILivenessSDK/Classes/main/Native/cpp/**" "${PODS_TARGET_SRCROOT}/AAILivenessSDK/Classes/main/**" "${PODS_TARGET_SRCROOT}/AAILivenessSDK/Classes/pu_headers" "${PODS_TARGET_SRCROOT}/AAILivenessSDK/Classes/DVSDKEvent"'

  # Header search paths: We now find C++ engine headers and third-party headers (ncnn/json11/encryption/http)
  # directly from the unified AAICVCommonSDK target.
  cv_header_search = "\"${DERIVED_FILE_DIR}/obfuscate_headers\" \"${PODS_ROOT}/../dev_pods/AAICVCommonSDK/submodules/guardian-cv-mobile/include\" \"${PODS_ROOT}/../dev_pods/AAICVCommonSDK/submodules/guardian-cv-mobile/src\" \"${PODS_ROOT}/AAICVCommonSDK/Frameworks/json11.xcframework/ios-arm64/Headers\" \"${PODS_ROOT}/AAICVCommonSDK/Frameworks/encryption.xcframework/ios-arm64/Headers\""

  # Script phase to map <http/fvlib.h> to http.xcframework's headers, avoiding conflicts.
  obfuscate_script_phase = {
    :name => 'Create http header alias for AAILivenessSDK',
    :script => <<-'SCRIPT',
        DEST_DIR="${DERIVED_FILE_DIR}/obfuscate_headers"
        CV_FW="${PODS_ROOT}/../dev_pods/AAICVCommonSDK/Frameworks"
        if [ "${PLATFORM_NAME}" = "iphonesimulator" ]; then
          HTTP_HEADERS="${CV_FW}/http.xcframework/ios-arm64_x86_64-simulator/http.framework/Headers"
        else
          HTTP_HEADERS="${CV_FW}/http.xcframework/ios-arm64/http.framework/Headers"
        fi
        mkdir -p "${DEST_DIR}"
        rm -f "${DEST_DIR}/http"
        ln -sf "${HTTP_HEADERS}" "${DEST_DIR}/http"
        SCRIPT
    :execution_position => :before_compile
  }

  s.subspec 'Core' do |cs|
    cs.dependency 'AAINetwork', '~> 1.1.0'
    cs.dependency 'AAICore', '~> 1.0.6'
  end

  # ---- EngineSource：内部调试（源码编译引擎，依赖 AAICVCommonSDK/EngineLiveness）----

  # ---- Standalone：客户单点（无 AAICVCommonSDK）----
  s.subspec 'Standalone' do |st|
    st.dependency 'AAILivenessSDK/Core'
    st.vendored_frameworks = 'Frameworks/Standalone/AAILivenessSDK.xcframework'
  end

  # ---- Coexistence：与 IQA 共存；仅 ncnn 由 AAICVCommonSDK 提供 ----
  s.subspec 'Coexistence' do |co|
    co.dependency 'AAILivenessSDK/Core'
    co.dependency 'AAICVCommonSDK/NcnnDynamic', '1.1.0-alpha.3'
    co.vendored_frameworks = 'Frameworks/Coexistence/AAILivenessSDK.xcframework'
    co.pod_target_xcconfig = {
      'OTHER_LDFLAGS' => '$(inherited) -framework "ncnn"',
    }
  end

end
