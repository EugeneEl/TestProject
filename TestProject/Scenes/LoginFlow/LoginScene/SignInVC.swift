//
//  SignInVC.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 16.01.2019.
//  Copyright © 2019 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

final class SignInVC: UIViewController {
    
    // MARK: - Vars
    
    fileprivate let mainView = SignInMainView()
    
    // MARK: - Initialization
    
    init(worker: Any) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private
    // MARK: - Helpers
    
    fileprivate func setupUI() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
}
