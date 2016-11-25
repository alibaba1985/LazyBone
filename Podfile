source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.0'

inhibit_all_warnings!


# SYSTEM OPATIONS

use_frameworks!

    # HTTP-NET-ENGINE
    
    pod 'Alamofire', '~> 3.5.0'
    
    # JSON TOOL
    
    pod 'SwiftyJSON', :git => 'https://github.com/SwiftyJSON/SwiftyJSON.git'
    
    # UI/UX
    
    pod 'Spring', :git => 'https://github.com/asiainfomobile/Spring.git', :branch => 'swift-2.3-migration'
    
    pod 'Cartography', '~> 0.7.0'
    
    pod 'SnapKit', '~> 0.22.0'
    
    pod 'AIAlertView', :git => 'https://github.com/asiainfomobile/AIAlertView.git'
    
    pod 'YYImage', '~> 1.0.1'

    pod 'UMengSocialCOM', '~> 5.2.1'
    
    # iOS Debug
    
    pod 'IQKeyboardManagerSwift'
    
    pod 'SVProgressHUD', '~> 1.0'
    
    pod 'iCarousel', '~> 1.8.2'




post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '2.3'
        end
    end
end