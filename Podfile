source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

def all_pods

pod 'Alamofire'
# Elegant HTTP Networking in Swift
# Homepage: https://github.com/Alamofire/Alamofire
# Source:   https://github.com/Alamofire/Alamofire.git

pod 'Localize-Swift'
# Swift-friendly localization and i18n syntax with in-app language switching.
# Homepage: https://github.com/marmelroy/Localize-Swift
# Source:   https://github.com/marmelroy/Localize-Swift.git

pod 'IQKeyboardManager'
# Codeless drop-in universal library allows to prevent issues of keyboard sliding up.
# Homepage: https://github.com/hackiftekhar/IQKeyboardManager
# Source: https://github.com/hackiftekhar/IQKeyboardManager.git

pod 'FXKeychain', '~> 1.5.3'
# FXKeychain is a lightweight wrapper around the Apple keychain APIs
# Homepage: https://github.com/nicklockwood/FXKeychain
# Source:   https://github.com/nicklockwood/FXKeychain.git

pod 'SDWebImage'
# Asynchronous image downloader with cache support with an UIImageView category.
# Homepage: https://github.com/rs/SDWebImage
# Source:   https://github.com/rs/SDWebImage.git

pod 'SnapKit', '~> 3.0'
# Harness the power of auto layout with a simplified, chainable syntax.
# Homepage: https://github.com/SnapKit/SnapKit
# Source:   https://github.com/SnapKit/SnapKit.git

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
            config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
            config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end

target "TestProject" do
    all_pods
end
