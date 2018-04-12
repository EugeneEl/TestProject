//
//  SafariService+Extension.swift
//  EGS
//
//  Created by Eugene Goloboyar on 20.03.2018.
//

import Foundation
import SafariServices

// this hack is done to handle status bar style on safari view controller
extension SFSafariViewController {
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.shared.statusBarStyle = .default
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        UIApplication.shared.statusBarStyle = StatusBarHelper.shared.style
    }
}
