# Uncomment this line to define a global platform for your project
platform :ios, '9.0'

#############################################################

# 忽略 pod 库 analyzer 静态分析警告
post_install do |installer|
    puts 'Removing static analyzer support'
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['OTHER_CFLAGS'] = "$(inherited) -Qunused-arguments -Xanalyzer -analyzer-disable-all-checks"
        end
    end
    # iOS11中AppIcon设置无效的问题
    copy_pods_resources_path = "Pods/Target Support Files/Pods-NotchNice/Pods-NotchNice-resources.sh"
    string_to_replace = '--compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"'
    assets_compile_with_app_icon_arguments = '--compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}" --app-icon "${ASSETCATALOG_COMPILER_APPICON_NAME}" --output-partial-info-plist "${BUILD_DIR}/assetcatalog_generated_info.plist"'
    text = File.read(copy_pods_resources_path)
    new_contents = text.gsub(string_to_replace, assets_compile_with_app_icon_arguments)
    File.open(copy_pods_resources_path, "w") {|file| file.puts new_contents }
end

# 忽略 pod 库警告
inhibit_all_warnings!

#############################################################


source 'https://github.com/CocoaPods/Specs.git'

use_modular_headers!

target 'NotchNice' do
    
    pod 'ZLKit', :path => '../../ZLKit/', :subspecs => ['ZLBasic', 'ZLAd']
    
    ############## Group
    
    # 基于 Github 上的 Reachability，参照apple官方文档做 IPv6 兼容处理
    pod 'Reachability', :git => 'http://techgit.meitu.com/iosmodules/Reachability.git', :tag => 'v3.2.1'
    
    ############## 开源 Pods
    
    # 进度 loading 库
    pod 'MBProgressHUD', '~> 0.9.1'
    # UI 布局库
    pod 'Masonry', '~> 1.1'
    # YYmolde
    pod 'YYModel', '~> 1.0.4'
    # LKDB 对FMDB的二次封装
    pod 'LKDBHelper'
    # THLabel
    pod 'THLabel'
    # loading View https://github.com/SVProgressHUD/SVProgressHUD
    pod 'SVProgressHUD'
    # 全能的tableView，支持多样式，封装度很好 https://github.com/shaohuihu/HSSetTableViewController
    pod 'HSSetTableViewController','~> 1.3.1'
    # 谷歌全家桶
    pod 'Google-Mobile-Ads-SDK'
    # 滴滴的开发辅助工具
    pod 'DoraemonKit/Core', '~> 3.0.2', :configurations => ['Debug'] #Required
    pod 'DoraemonKit/WithGPS', '~> 3.0.2', :configurations => ['Debug'] #Optional
    pod 'DoraemonKit/WithLoad', '~> 3.0.2', :configurations => ['Debug'] #Optional
    
end



