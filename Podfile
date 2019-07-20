source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

def all_pods
    
    pod 'Alamofire'
    # Elegant HTTP Networking in Swift
    # Homepage: https://github.com/Alamofire/Alamofire
    # Source:   https://github.com/Alamofire/Alamofire.git
    
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
    
    pod 'SnapKit'
    # Harness the power of auto layout with a simplified, chainable syntax.
    # Homepage: https://github.com/SnapKit/SnapKit
    # Source:   https://github.com/SnapKit/SnapKit.git
    
    pod 'MBProgressHUD'
    # An iOS drop-in class that displays a translucent HUD with an indicator.
    # Homepage: https://github.com/jdg/MBProgressHUD
    # Source: https://github.com/jdg/MBProgressHUD.git
    
    pod 'Dotzu', :git => 'https://github.com/EugeneGoloboyar/Dotzu.git', :commit => '978579b6881a6028f2e9f0ef88d76dcf9ae935a4'
    # In-App iOS Debugging Tool With Enhanced Logging, Networking Info, Crash reporting And More.
    # This fork is used for screen recording with Replay kit.
    # Homepage: https://github.com/remirobert/Dotzu
    # Source: https://github.com/remirobert/Dotzu.git
    
    pod 'MaterialComponents'
    # UI controls for Material Design
    # Homepage: https://material.io/develop/ios/
    # Source: https://github.com/material-components/material-components-ios
    
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
            config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
            config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
            config.build_settings['ENABLE_BITCODE'] = 'NO'
            config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
        end
    end
end

target "TestProject" do
    all_pods
end

