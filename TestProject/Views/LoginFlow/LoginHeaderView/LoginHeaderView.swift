//
//  LoginHeaderView.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 20.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

class LoginHeaderView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet fileprivate weak var logoContainerView: UIView!
    @IBOutlet fileprivate weak var logoImageView: UIImageView!
    
    // MARK: - Override
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        logoImageView.image = Bundle.provideAppIcon()
        backgroundColor = UIColor(hex: "4527A0")
    }
}
