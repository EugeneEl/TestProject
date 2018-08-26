//
//  MenuTabBarItem.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 26.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

struct TabBarItemUI {
    let title: String
    let image: UIImage
}

enum MenuTabBarItem {
    case feed
    case settings
    
    private static let feedUI = TabBarItemUI(title: "Feed", image: #imageLiteral(resourceName: "feedTabBarItem"))
    private static let settingsUI = TabBarItemUI(title: "Settings", image: #imageLiteral(resourceName: "profileTabBarItem"))
    
    var tabBarItem: UITabBarItem {
        return UITabBarItem(title: itemUI.title, image: itemUI.image, selectedImage: nil)
    }
    
    private var itemUI: TabBarItemUI {
        switch self {
        case .feed:
            return MenuTabBarItem.feedUI
        case .settings:
            return MenuTabBarItem.settingsUI
        }
    }
}
