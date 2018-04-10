//
//  HUDDisplayHelper.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 10.04.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import MBProgressHUD

protocol HUDDisplaying: class {
    static func showHUDInView(_ view: UIView, animated: Bool)
    static func hideHUDInView(_ view: UIView, animated: Bool)
}

final class HudHelper: HUDDisplaying {
    
    static func showHUDInView(_ view: UIView, animated: Bool) {
        MBProgressHUD.showAdded(to: view, animated: animated)
    }
    
    static func hideHUDInView(_ view: UIView, animated: Bool) {
        MBProgressHUD.hide(for: view, animated: animated)
    }
}
