//
//  LoginFooterView.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 25.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

protocol LoginFooterViewInteracting: class {
    func loginDidTap()
}

class LoginFooterView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet fileprivate weak var loginButton: UIButton!
    
    // MARK: Constants
    
    // MARK: - Vars
    
    weak var delegate: LoginFooterViewInteracting?
    
    // MARK: - Override
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    // MARK: - Private
    // MARK: - Actions
    
    @IBAction fileprivate func loginTap() {
        delegate?.loginDidTap()
    }
    
    // MARK: - Helpers
    
    private func setupUI() {
        backgroundColor = Constants.Colors.background
        loginButton.cornerRadius = 3
        loginButton.backgroundColor = Constants.Colors.controls
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
    }
}
