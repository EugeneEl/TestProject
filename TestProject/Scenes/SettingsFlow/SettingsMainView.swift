//
//  SettingsMainView.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 7/20/19.
//  Copyright © 2019 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

final class SettingsMainView: UIView {
    
    // MARK: - Public
    
    let logoutButton: UIButton = {
        let button = UIButton()
        let title = "settings_logout_button_title".localized
        let attributedText = title.attributed(.font(UIFont.systemFont(ofSize: 18, weight: .semibold)),
                                              .alignment(.center),
                                              .color(.white))
        button.setAttributedTitle(attributedText, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        button.backgroundColor = Constants.Colors.lightBlue
        button.cornerRadius = 8
        
        return button
    }()
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    // MARK: - Required initializer
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    // MARK: - Helpers
    
    fileprivate func setupUI() {
        addSubview(logoutButton)
        
        logoutButton.snp.makeConstraints { (maker) in
            maker.height.equalTo(50)
            maker.centerX.centerY.equalToSuperview()
        }
    }
}
