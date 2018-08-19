//
//  LoginFormBuilder.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 19.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

/// Fragment types for composing Settings Main Screen.
enum SettingsMainFragmentType {
    case myInfo
    case support
    case notification
    case location
    case logout
    
    var height: CGFloat {
        switch self {
        case .myInfo, .support:
            return 44
        case .location, .notification:
            return 70
        case .logout:
            return 47
        }
    }
}

final class LoginFormBuilder {
    
    /// Provide an input control and view for settings fragment type.
    ///
    /// - Parameters:
    ///   - fragment: `SettingsMainFragmentType` object.
    ///   - viewController: `UIViewController` instance to pass in fragment (required for navigation for specific fragment).
    /// - Returns: A tuple with `MainProfileControl` inputControl (contains input and validation logic) and `UIView` instance for fragment.
    static func provideInputControlModuleForFragment(_ fragment: SettingsMainFragmentType, viewController: UIViewController) -> (MainProfileControl, UIView) {
        switch fragment {
        case .myInfo:
            let infoView = SettingsInfoView.instantiateView()
            infoView.configureWithText("geo_report_myinfo_title".localized)
            let inputControl = SettingsInfoInputControl(settingsInfoView: infoView, viewController: viewController, type: fragment)
            infoView.delegate = inputControl
            
            return (inputControl, infoView)
        case .support:
            let infoView = SettingsInfoView.instantiateView()
            infoView.configureWithText("profile_settings_support_hint".localized, isImageHidden: false)
            let inputControl = SettingsInfoInputControl(settingsInfoView: infoView, viewController: viewController, type: fragment)
            
            return (inputControl, infoView)
        case .notification:
            let notificationPermissionsView = SettingsPermissionInputView.instantiateView()
            let inputControl = PushSettingsPermissionInputControl(notificationView: notificationPermissionsView)
            notificationPermissionsView.delegate = inputControl
            inputControl.configureNotificationView()
            
            let topUI = SettingsSeparatorUI(isVisible: true, color: UIColor(hex:"C8C7CC"), hasLeftPadding: false)
            let bottomUI = SettingsSeparatorUI(isVisible: true, color: UIColor.black.withAlphaComponent(0.12), hasLeftPadding: true)
            
            notificationPermissionsView.configureSeparators(topUI: topUI, bottomUI: bottomUI)
            
            return (inputControl, notificationPermissionsView)
        case .location:
            let notificationPermissionsView = SettingsPermissionInputView.instantiateView()
            let inputControl = LocationSettingsPermissionInputControl(notificationView: notificationPermissionsView)
            notificationPermissionsView.delegate = inputControl
            inputControl.configureNotificationView()
            
            let topUI = SettingsSeparatorUI(isVisible: false, color: UIColor(hex:"C8C7CC"), hasLeftPadding: false)
            let bottomUI = SettingsSeparatorUI(isVisible: true, color: UIColor(hex:"C8C7CC"), hasLeftPadding: false)
            
            notificationPermissionsView.configureSeparators(topUI: topUI, bottomUI: bottomUI)
            
            return (inputControl, notificationPermissionsView)
        case .logout:
            let logoutView = SettingsLogoutView.instantiateView()
            
            let inputControl = SettingsLogoutInputControl(viewController: viewController)
            logoutView.delegate = inputControl
            
            return (inputControl, logoutView)
        }
    }
}
