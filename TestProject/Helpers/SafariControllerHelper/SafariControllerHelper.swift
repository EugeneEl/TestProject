//
//  SafariControllerHelper.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 24.04.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import SafariServices

/// SafariControllerHelper is responsible for opening url's in SafariViewController.
final class SafariControllerHelper: NSObject {
    
    // MARK: - Vars
    
    fileprivate weak var viewController: UIViewController?
    
    // MARK: - Initialization
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    // MARK: - Public
    
    /// Open URL in SafariViewController.
    ///
    /// - Parameter url: `URL` to open.
    func openURLInSafariViewController(_ url: URL) {
        let safariVC = SFSafariViewController(url: url, entersReaderIfAvailable: true)
        safariVC.delegate = self
        viewController?.present(safariVC, animated: true, completion: nil)
    }
}

// MARK: - SFSafariViewControllerDelegate

extension SafariControllerHelper: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
