//
//  StatusBarHelper.swift
//  EGS
//
//  Created by Eugene Goloboyar on 20.03.2018.

import Foundation

/// Small class which helps to restore status bar style when dismissing external 'remote' view controllers (like `SafariViewController`)
final class StatusBarHelper {
    
    // MARK: - Vars
    
    static let shared: StatusBarHelper = StatusBarHelper()
    fileprivate (set) internal var style: UIStatusBarStyle
    
    // MARK: - Initialization
    
    private init() {
        self.style = UIApplication.shared.statusBarStyle
    }
}
