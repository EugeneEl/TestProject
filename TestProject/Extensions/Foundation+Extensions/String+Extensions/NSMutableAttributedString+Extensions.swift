//
//  NSMutableAttributedString+Extensions.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 16.01.2019.
//  Copyright © 2019 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

enum StringAttribute {
    case color(UIColor)
    case font(UIFont)
    case minimumLineHeight(CGFloat)
    case alignment(NSTextAlignment)
    case characterSpacing(CGFloat)
    case lineBreakMode(NSLineBreakMode)
}

extension String {
    
    func attributed(_ attributes: StringAttribute...) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString.init(string: self)
        let pargraphStyle = NSMutableParagraphStyle()
        
        for attribute in attributes {
            switch attribute {
            case .color(let color):
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: NSMakeRange(0, nsstringLength))
                
            case .font(let font):
                attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, nsstringLength))
                
            case .characterSpacing(let characterSpacing):
                attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSMakeRange(0,nsstringLength))
                
            case .minimumLineHeight(let minimumLineHeight):
                pargraphStyle.minimumLineHeight = minimumLineHeight
                
            case .alignment(let alignment):
                pargraphStyle.alignment = alignment
                
            case .lineBreakMode(let lineBreakMode):
                pargraphStyle.lineBreakMode = lineBreakMode
            }
        }
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: pargraphStyle, range: NSMakeRange(0, nsstringLength))
        
        return attributedString
    }
}
