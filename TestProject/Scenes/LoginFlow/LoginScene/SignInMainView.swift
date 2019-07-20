//
//  SignInMainView.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 16.01.2019.
//  Copyright © 2019 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

final class SignInMainView: UIView {
    
    // MARK: - Public Vars
    
    let signInButton: UIButton = {
        let button = UIButton()
        let title = "login_scene_sign_in_title".localized
        let attributedText = title.attributed(.font(UIFont.systemFont(ofSize: 18, weight: .semibold)),
                                              .alignment(.center),
                                              .color(.white))
        button.setAttributedTitle(attributedText, for: .normal)
        
        button.backgroundColor = Constants.Colors.lightBlue
        button.cornerRadius = 8
        
        return button
    }()
    
    let emailView = FormInputView.instantiateView()
    let passwordView = FormInputView.instantiateView()
    
    // MARK: - Private Vars
    
    fileprivate let scrollView = ViewHelperBuilder.buildScrollView()
    fileprivate let stackView = ViewHelperBuilder.buildStackViewWithAxis(.vertical)

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
        backgroundColor = Constants.Colors.dirtyWhite
        addSubview(scrollView)
        
        stackView.spacing = 8
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        ViewHelperBuilder.setupStackViewScrollInView(self, stackView: stackView, scrollView: scrollView)
        
        setupSubviews()
    }
    
    fileprivate func setupSubviews() {
        emailView.snp.makeConstraints { maker in
            maker.height.equalTo(90)
        }
        passwordView.snp.makeConstraints { maker in
            maker.height.equalTo(90)
        }
        
        emailView.backgroundColor = Constants.Colors.dirtyWhite
        emailView.cornerRadius = 8

        passwordView.backgroundColor = Constants.Colors.dirtyWhite
        passwordView.cornerRadius = 8 
        
        stackView.addEmptyViewWithFixedValue(210)
        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(passwordView)
        stackView.addEmptyViewWithFixedValue(16)
        stackView.addArrangedSubviewWithFixedValue(signInButton, value: 50)
        
        let bottomPaddingView = UIView()
        stackView.addArrangedSubview(bottomPaddingView)
    }
}
