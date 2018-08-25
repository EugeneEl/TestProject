 //
//  NewLoginVC.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 19.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

final class NewLoginVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    // MARK: - Vars
    
    private let presenter = NewLoginPresenter()
    fileprivate var cellsDictionary = [IndexPath : UITableViewCell]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.backgroundColor = UIColor(hex: "4527A0")
        view.backgroundColor = UIColor(hex: "4527A0")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - UITableViewDataSource

extension NewLoginVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = cellsDictionary[indexPath] {
            return cell
        }
        
        let row = indexPath.row
        
        guard let loginFormType = presenter.formTypes[safe: row] else {
            return UITableViewCell()
        }
        
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        let formModule = LoginFormBuilder.provideInputControlModuleForFragment(loginFormType)
        
        let inputControl = formModule.0
        let fragemntView = formModule.1
        
        presenter.inputControllers.append(inputControl)
        
        cell.backgroundColor = .clear
        cell.contentView.addSubview(fragemntView)
        fragemntView.constraintToSuperviewEdges(leading: 16, trainling: 16, bottom: 0, top: 0)
        
        cellsDictionary[indexPath] = cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.formTypes.count
    }
}

// MARK: - UITableViewDelegate
 
extension NewLoginVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LoginFormType.inputHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = LoginHeaderView.instantiateView()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 190
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = LoginFooterView.instantiateView()
        return footerView
    }
}
 
 // MARK: - ViewControllerUIConfigurating
 
 extension NewLoginVC: ViewControllerUIConfigurating {
    var navigationBarAppearance: NavigationBarAppearance? {
        return nil
    }
    
    var isNavigationBarHidden: Bool {
        return true
        
    }
    
    var isBackButtonVisible: Bool {
        return false
    }
 }
