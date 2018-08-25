//
//  ViewControllersProvider.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 29.03.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

enum StoryboardId: String {
    case main = "Main"
    case login = "Login"
    case settings = "Settings"
}

extension UIStoryboard {
    static func provideStoryboardWithId(_ storyboardId: StoryboardId) -> UIStoryboard {
        let storyboard = UIStoryboard(name: storyboardId.rawValue, bundle: nil) as UIStoryboard?
        assert(storyboard != nil, "Storyboard name is incorrect")
        
        return storyboard!
    }
    
    static func provideMain() -> UIStoryboard {
        return UIStoryboard.provideStoryboardWithId(.main)
    }
    
    static func provideLogin() -> UIStoryboard {
        return UIStoryboard.provideStoryboardWithId(.login)
    }
}

protocol StoryboardInitializing {}

extension UIViewController: StoryboardInitializing {}
extension UIViewController {
    static func className() -> String {
        return String(describing: self)
    }
}

extension StoryboardInitializing where Self: UIViewController {
    
    static func instantiateFromStoryboardId(_ storyboardId: StoryboardId) -> Self {
        let vcIdentifier = self.className()
        
        let storyboard = UIStoryboard.provideStoryboardWithId(storyboardId)
        let vc = storyboard.instantiateViewController(withIdentifier: vcIdentifier)
    
        return vc as! Self
    }
}
