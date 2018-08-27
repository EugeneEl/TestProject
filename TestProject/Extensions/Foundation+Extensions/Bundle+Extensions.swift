//
//  Bundle+Extensions.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 20.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

extension Bundle {    
    static func provideAppIcon() -> UIImage? {
        guard let iconsDictionary = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String : Any],
            let primaryIconsDictionary = iconsDictionary["CFBundlePrimaryIcon"] as? [String : Any],
            let iconFiles = primaryIconsDictionary["CFBundleIconFiles"] as? [String],
            let lastIcon = iconFiles.last else { return nil }
        return UIImage(named: lastIcon)
    }
}
