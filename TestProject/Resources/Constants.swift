//
//  Constants.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 25.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    struct Colors {
        static let background = UIColor(hex: "4527A0")
        static let controls = UIColor(hex: "66BB6A")
        static let grey = UIColor(hex: "ffffff")
        static let lightBlue = UIColor(hex: "00B7AF")
        static let transparentLightBlue = UIColor(hex: "00B7AF").withAlphaComponent(0.1)
        static let buttonTint = UIColor.white
        static let lightGrey = UIColor(hex: "7A7F85")
        static let darkGrey = UIColor(hex: "4B5352")
        static let white = UIColor(hex: "FFFFFF")
        static let black = UIColor(hex: "000000")
        static let dirtyWhite = UIColor(hex: "F3F4F4")
        static let red = UIColor(hex: "B53100")
    }
}

enum ProximaNovaFont: String {
    case regular = "ProximaNova-Regular"
    case semibold = "ProximaNova-Semibold"
    case bold = "ProximaNova-Bold"
    
    func fontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: rawValue, size: size)!
    }
}
