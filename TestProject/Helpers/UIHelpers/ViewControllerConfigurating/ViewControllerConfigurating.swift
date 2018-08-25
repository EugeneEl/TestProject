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

struct NavigationBarAppearance {
    var isSeparatorVisible: Bool?
    var translucent: Bool
    var navigationBarColor: UIColor?
    var navigationBarTintColor: UIColor
    var navigationTitle: String?
    var navigationTitleColor: UIColor
    var leftItem: UIBarButtonItem?
    var rightItem: UIBarButtonItem?
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
        
        //hide back button if needed
        if !isBackButtonVisible && navigationBarAppearance == nil {
            self.navigationItem.leftBarButtonItem = nil
        }
    }
    
    fileprivate func configureNavigationBar(_ appearance: NavigationBarAppearance) {
        if !isNavigationBarHidden {
            let navigationBar = navigationController?.navigationBar
            
            navigationBar?.isHidden = false
            
            // on default setup back button for left bar button item
//            replaceBackButton()
            
            // remove separator if needed
            if let visible = appearance.isSeparatorVisible {
                if !visible {
                    let img = UIImage()
                    self.navigationController?.navigationBar.shadowImage = img
                    self.navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
                }
            }
            
            // setup translucency
            navigationBar?.isTranslucent = appearance.translucent
            
            // setup navigation bar colors
            navigationController?.navigationBar.barTintColor = appearance.navigationBarColor
            navigationController?.navigationBar.tintColor = appearance.navigationBarTintColor
            
            // setup navigation title
            setupNavigationTitle(appearance.navigationTitle, titleColor: appearance.navigationTitleColor)
            
            // setup barItems if needed
            
            navigationItem.leftBarButtonItem = appearance.leftItem
            navigationItem.setHidesBackButton(!isBackButtonVisible, animated: false)
            navigationItem.rightBarButtonItem = appearance.rightItem
            
        } else {
            navigationController?.navigationBar.isHidden = true
        }
    }
    
    fileprivate func setupNavigationTitle(_ title: String?, titleColor: UIColor) {
        let navigationTitleView = UIView(frame: navigationViewFrame)
        
        let titleConfigurationBlock = {[unowned self] () -> UILabel in
            let titleLabel = UILabel(frame: self.titleFrame)
            titleLabel.text = title
            titleLabel.textColor = titleColor
            titleLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
            
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
    }
}
