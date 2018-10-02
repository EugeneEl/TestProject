//
//  ViewControllerConfigurating.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 29.03.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

enum TitleStyle {
    case full
    case cropped(percents: Int)
}

struct NavigationBarTitleUI {
    let color: UIColor
    let font: UIFont
}

enum NavigationBarTitleStyle {
    case text(String, NavigationBarTitleUI)
    case customView(UIView)
}

struct NavigationBarUI {
    var isSeparatorVisible: Bool?
    var translucent: Bool
    let navigationBarColor: UIColor?
    let navigationBarTintColor: UIColor
    let titleStyle: NavigationBarTitleStyle
}

enum NavigationBarItem {
    case single(UIBarButtonItem)
    case multiple([UIBarButtonItem])
}

struct NavigationBarAppearance {
    var navigationBarUI: NavigationBarUI
    var leftItem: NavigationBarItem?
    var rightItem: NavigationBarItem?
}

extension NavigationBarAppearance {
}

/**
 To use this just conform your controller to this protocol and
 call configureAsARNTransitionNavigationController() method in viewWillAppear method.
 
 
 Here you can find default implementation of properties in this protocol
 and a lot other things used in this project.
 
 
 If expected behaviour of implementation of this protocol is different from default
 just change whatever you want in properties/method in the controller.
 
 - navigationBarAppearance: NavigationBarAppearance? {get}
 - statusBarStyle: .light/.default/etc {get}
 - isNavigationBarHidden: Bool {get}
 - isBackButtonVisible: Bool {get}
 */
protocol ViewControllerUIConfigurating {
    var navigationBarAppearance: NavigationBarAppearance? {get}
    var isNavigationBarHidden: Bool {get}
    var isBackButtonVisible: Bool {get}
    func configureNavigationBarUI()
}

/*
 *  Default implementation of protocol
 */
extension ViewControllerUIConfigurating where Self: UIViewController {
    fileprivate var navigationViewFrame: CGRect { return CGRect(x: 0, y: 0, width: 100, height: 40) }
    fileprivate var titleFrame: CGRect { return CGRect(x: 28, y: 0, width: 100, height: 20) }
    
    // override to customize nav bar appearance
    var navigationBarAppearance: NavigationBarAppearance? {
        return nil
    }
    
    var statusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    var isNavigationBarHidden: Bool {
        return true
    }
    
    var isBackButtonVisible: Bool {
        return true
    }
    
    func configureNavigationBarUI() {
        
        if let nc = self.navigationController as? BaseNavigationController {
            nc.statusBarStyle = statusBarStyle
        }
        
        if let appearance = navigationBarAppearance {
            configureNavigationBar(appearance)
        }
        
        navigationController?.setNavigationBarHidden(isNavigationBarHidden, animated: true)
    }
    
    fileprivate func configureNavigationBar(_ appearance: NavigationBarAppearance) {
        if !isNavigationBarHidden {
            let navigationBar = navigationController?.navigationBar
            
            navigationBar?.isHidden = false
            
            // remove separator if needed
            if let visible = appearance.navigationBarUI.isSeparatorVisible {
                if !visible {
                    hideSeparator()
                } 
            }
            
            // setup translucency
            navigationBar?.isTranslucent = appearance.navigationBarUI.translucent
            
            // setup navigation bar colors
            navigationController?.navigationBar.barTintColor = appearance.navigationBarUI.navigationBarColor
            navigationController?.navigationBar.tintColor = appearance.navigationBarUI.navigationBarTintColor
            
            // setup navigation title
            setupNavigationTitleWithStyle(appearance.navigationBarUI.titleStyle)
            
            setupItemsWithAppearance(appearance)
        } else {
            navigationController?.navigationBar.isHidden = true
        }
    }
    
    fileprivate func hideSeparator() {
        let img = UIImage()
        self.navigationController?.navigationBar.shadowImage = img
        self.navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
    }
    
    fileprivate func setupItemsWithAppearance(_ appearance: NavigationBarAppearance) {
        if let leftNavigationItem = appearance.leftItem {
            switch leftNavigationItem {
            case .single(let item):
                navigationItem.leftBarButtonItem = item
            case .multiple(let items):
                navigationItem.leftBarButtonItems = items
            }
        } else {
            if isBackButtonVisible {
                // replace back button
            } else {
                navigationItem.setHidesBackButton(true, animated:true);
            }
        }
        
        if let rightNavigationItem = appearance.rightItem {
            switch rightNavigationItem {
            case .single(let item):
                navigationItem.rightBarButtonItem = item
            case .multiple(let items):
                navigationItem.rightBarButtonItems = items
            }
        }
    }
    
    fileprivate func setupNavigationTitleWithStyle(_ style: NavigationBarTitleStyle) {
        switch style {
        case .text(let titleText, let ui):
            let navigationTitleView = UIView(frame: navigationViewFrame)
            
            let titleConfigurationBlock = {[unowned self] () -> UILabel in
                let titleLabel = UILabel(frame: self.titleFrame)
                titleLabel.text = titleText
                titleLabel.textColor = ui.color
                titleLabel.font = ui.font
                
                titleLabel.textAlignment = .center
                
                return titleLabel
            }
            
            let label = titleConfigurationBlock()
            navigationTitleView.addSubview(label)
            var width = label.intrinsicContentSize.width
            if width > 180 {
                label.snp.makeConstraints { make in
                    make.centerX.equalTo(label.superview!)
                    make.centerY.equalTo(label.superview!)
                    make.width.equalTo(width)
                    make.height.equalTo(label.intrinsicContentSize.height)
                }
            } else {
                label.constraintToSuperViewCenterRelyOnIntristicSize()
            }
            navigationTitleView.frame.size.width = width
            navigationItem.titleView = navigationTitleView
        case .customView(let view):
            navigationItem.titleView = view
        }
    }
}
