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
    
    // MARK: - Vars
    
    fileprivate let scrollView: UIScrollView = {
        let scrollView = UIScrollView.init()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        return stackView
    }()
    
    fileprivate let signInButton = UIButton()
    
    let emailView = FormInputView.instantiateView()
    let passwordView = FormInputView.instantiateView()
    
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
        backgroundColor = .white
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        scrollView.snp.makeConstraints { maker in
            maker.width.equalTo(stackView.snp.width)
        }
        setupStackView()
    }
    
    fileprivate func setupSignInButton() {
        
    }
    
    fileprivate func setupStackView() {
        emailView.snp.makeConstraints { maker in
            maker.height.equalTo(85)
        }
        passwordView.snp.makeConstraints { maker in
            maker.height.equalTo(85)
        }
        let bottomPaddingView = UIView()
        
        stackView.addEmptyViewWithFixedValue(210)
        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(passwordView)
        stackView.addArrangedSubview(bottomPaddingView)
    }
}
