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
    
    
}

// MARK: - UITableViewDataSource

extension NewLoginVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = cellsDictionary[indexPath] {
            return cell
        }
        
        let section = indexPath.section
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
        
        cell.contentView.addSubview(fragemntView)
        fragemntView.constraintToSuperviewEdges()
        
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
}
