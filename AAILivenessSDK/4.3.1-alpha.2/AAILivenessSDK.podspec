#
# Be sure to run `pod lib lint AAILivenessSDK1.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html#

Pod::Spec.new do |s|
  s.name             = 'AAILivenessSDK'
  s.version          = '4.3.1-alpha.2'
  s.summary          = 'AAILivenessSDK — liveness detection.'

  s.description      = <<-DESC
Liveness detection SDK. Customer subspecs Standalone and Coexistence ship prebuilt
AAILivenessSDK.xcframework (shell + full guardian-cv-mobile engine C++ + static
json11/encryption/http). Standalone also embeds static ncnn; Coexistence loads
dynamic ncnn via AAICVCommonSDK/NcnnOnly. Internal EngineSource for monorepo debug.
                       DESC

  s.homepage         = 'https://github.com/loong/AAILivenessSDK1'
  s.license      = { :type => 'example', :text => <<-LICENSE
                    LICENSE
                    }
  s.author           = { 'loong' => 'yulong.chen@advancegroup.com' }
  s.source           = { :http => 'https://prod-guardian-cv.oss-ap-southeast-5.aliyuncs.com/sdk/iOS-liveness-detection/4.3.1-alpha.2/AAILivenessSDK-V4.3.1-alpha.2.tar.bz2', type: :tbz }

  s.ios.deployment_target = '10.0'

  # ---- subspec 矩阵 ----
  #   Core              — 纯依赖容器
  #   EngineSource      — monorepo 联调：liveness/ 源码 + AAICVCommonSDK/EngineSource
  #   StandaloneBuild   — 发版打 xcframework（静态 ncnn），不发布
  #   CoexistenceBuild  — 发版打 xcframework（动态 ncnn），不发布
  #   Standalone        — 客户单点：Frameworks/Standalone/*.xcframework，无 AAICVCommonSDK
  #   Coexistence       — 客户共存：Frameworks/Coexistence/*.xcframework + NcnnOnly
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
  shell_user_header_search_paths = '"${PODS_TARGET_SRCROOT}/AAILivenessSDK/Classes/main/Native/cpp/**"'

  full_engine_source_files = [
    'AAILivenessSDK/submodules/guardian-cv-mobile/src/common/',
    'AAILivenessSDK/submodules/guardian-cv-mobile/src/models/',
    'AAILivenessSDK/submodules/guardian-cv-mobile/src/liveness/',
  ]
  full_engine_exclude_files = [
    'AAILivenessSDK/submodules/guardian-cv-mobile/src/common/viz.*',
    'AAILivenessSDK/submodules/guardian-cv-mobile/src/common/http_client.*',
    'AAILivenessSDK/submodules/guardian-cv-mobile/src/common/test_core.h',
    'AAILivenessSDK/submodules/guardian-cv-mobile/src/common/*.txt',
    'AAILivenessSDK/submodules/guardian-cv-mobile/src/models/*.txt',
    'AAILivenessSDK/submodules/guardian-cv-mobile/src/liveness/http_client.*',
  ]
  full_engine_private_headers = [
    'AAILivenessSDK/submodules/guardian-cv-mobile/src/**/*.h',
    'AAILivenessSDK/submodules/guardian-cv-mobile/src/**/*.hpp',
  ]

  cv_fw_monorepo = '${PODS_ROOT}/../dev_pods/AAICVCommonSDK/Frameworks'
  cv_header_search = "\"${DERIVED_FILE_DIR}/obfuscate_headers\" \"#{cv_fw_monorepo}/json11.xcframework/ios-arm64/Headers\" \"#{cv_fw_monorepo}/encryption.xcframework/ios-arm64/Headers\" \"#{cv_fw_monorepo}/http.xcframework/ios-arm64/http.framework/Headers\" \"#{cv_fw_monorepo}/ncnn.xcframework/ios-arm64/ncnn.framework/Headers\""
  cv_header_search_standalone = "\"${DERIVED_FILE_DIR}/obfuscate_headers\" \"#{cv_fw_monorepo}/json11.xcframework/ios-arm64/Headers\" \"#{cv_fw_monorepo}/encryption.xcframework/ios-arm64/Headers\" \"#{cv_fw_monorepo}/http.xcframework/ios-arm64/http.framework/Headers\" \"#{cv_fw_monorepo}/Static/ncnn.xcframework/ios-arm64/Headers\""
  cv_user_header_engine = "#{shell_user_header_search_paths} \"${PODS_TARGET_SRCROOT}/AAILivenessSDK/submodules/guardian-cv-mobile/src\" \"${PODS_TARGET_SRCROOT}/AAILivenessSDK/submodules/guardian-cv-mobile/src/common\" \"${PODS_TARGET_SRCROOT}/AAILivenessSDK/submodules/guardian-cv-mobile/src/liveness\" \"${PODS_TARGET_SRCROOT}/AAILivenessSDK/submodules/guardian-cv-mobile/src/models\" \"${DERIVED_FILE_DIR}/obfuscate_headers\""

  obfuscate_script_phase = {
    :name => 'Create engine header aliases',
    :script => <<-'SCRIPT',
        DEST_DIR="${DERIVED_FILE_DIR}/obfuscate_headers"
        INCLUDE_DIR="${PODS_TARGET_SRCROOT}/AAILivenessSDK/submodules/guardian-cv-mobile/include"
        CV_FW="${PODS_ROOT}/../dev_pods/AAICVCommonSDK/Frameworks"
        if [ "${PLATFORM_NAME}" = "iphonesimulator" ]; then
          HTTP_HEADERS="${CV_FW}/http.xcframework/ios-arm64_x86_64-simulator/http.framework/Headers"
        else
          HTTP_HEADERS="${CV_FW}/http.xcframework/ios-arm64/http.framework/Headers"
        fi
        mkdir -p "${DEST_DIR}"
        for name in obfuscate ncnn encryption; do
          rm -f "${DEST_DIR}/${name}"
          ln -sf "${INCLUDE_DIR}/${name}" "${DEST_DIR}/${name}"
        done
        rm -f "${DEST_DIR}/http"
        ln -sf "${HTTP_HEADERS}" "${DEST_DIR}/http"
        SCRIPT
    :execution_position => :before_compile
  }

  s.subspec 'Core' do |cs|
    cs.dependency 'AAINetwork', '~> 1.1.0'
    cs.dependency 'AAICore', '~> 1.0.6'
  end


  # ---- StandaloneBuild：发版 archive（全引擎 + 静态 ncnn/json11/encryption/http）----

  # ---- CoexistenceBuild：发版 archive（全引擎 + 静态三库；ncnn 动态，不链入二进制）----

  # ---- Standalone：客户单点（无 AAICVCommonSDK）----
  s.subspec 'Standalone' do |st|
    st.dependency 'AAILivenessSDK/Core'
    st.vendored_frameworks = 'Frameworks/Standalone/AAILivenessSDK.xcframework'
  end

  # ---- Coexistence：与 IQA 共存；仅 ncnn 由 AAICVCommonSDK 提供 ----
  s.subspec 'Coexistence' do |co|
    co.dependency 'AAILivenessSDK/Core'
    co.dependency 'AAICVCommonSDK/NcnnOnly', '1.1.0-alpha.2'
    co.vendored_frameworks = 'Frameworks/Coexistence/AAILivenessSDK.xcframework'
    co.pod_target_xcconfig = {
      'OTHER_LDFLAGS' => '$(inherited) -framework "ncnn"',
    }
  end

end
