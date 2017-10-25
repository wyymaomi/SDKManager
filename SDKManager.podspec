#
# Be sure to run `pod lib lint SDKManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'SDKManager'
    s.version          = '0.1.1'
    s.summary          = '第三方SDK统一管理组件'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

    s.description      = <<-DESC
TODO: Add long description of the pod here.
DESC

    s.homepage         = 'https://github.com/wyy/SDKManager'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'wyy' => 'wyymaomi@163.com' }
    s.source           = { :git => 'https://github.com/wyy/SDKManager.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'
    s.requires_arc = true

    #组件对外提供服务接口
    s.subspec 'CoreService' do |ss|
        ss.public_header_files = 'SDKManager/CoreService/SDKManager.h','SDKManager/CoreService/ServiceInterface/*.h'
        ss.source_files = 'SDKManager/CoreService/**/*.{h,m,mm}'
        ss.resources = ['SDKManager/CoreService/SDKServiceConfig.plist']
    end

    #支付宝平台SDK集成
    s.subspec 'AlipayPlatform' do |ss|
        ss.public_header_files = 'SDKManager/AlipayPlatform/*.h','SDKManager/AlipayPlatform/**/*.h'
        ss.source_files = 'SDKManager/AlipayPlatform/*.{h,m,mm}','SDKManager/AlipayPlatform/**/*.{h,m,mm}'
        ss.vendored_frameworks = 'SDKManager/AlipayPlatform/AlipaySDK/AlipaySDK.framework'
        ss.resources = ['SDKManager/AlipayPlatform/**/*.{bundle}']
        ss.frameworks = 'CoreMotion','SystemConfiguration','CoreTelephony','QuartzCore','CoreText','CoreGraphics','CFNetwork','UIKit','Foundation'
        ss.libraries = 'z','c++'
        ss.dependency 'SDKManager/CoreService'
    end

    #微信平台SDK集成
    s.subspec 'WechatPlatform' do |ss|
        ss.public_header_files = 'SDKManager/WechatPlatform/*.h','SDKManager/WechatPlatform/**/*.h'
        ss.source_files = 'SDKManager/WechatPlatform/**/*.{h,m,mm}'
        ss.vendored_libraries = 'SDKManager/WechatPlatform/WechatSDK/libWeChatSDK.a'
        ss.frameworks = 'SystemConfiguration','Security','CoreTelephony','CFNetwork'
        ss.libraries = 'z','sqlite3.0','c++'
        ss.dependency 'SDKManager/CoreService'
    end

    # s.resource_bundles = {
    #   'SDKManager' => ['SDKManager/Assets/*.png']
    # }

    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3'
end
