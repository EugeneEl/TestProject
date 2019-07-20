//
//  String+Localization.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 16.01.2019.
//  Copyright © 2019 Eugene Goloboyar. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, value: "", comment: "")
    }
}
