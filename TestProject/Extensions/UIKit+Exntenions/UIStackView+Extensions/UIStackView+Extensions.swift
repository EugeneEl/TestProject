//
//  UIStackView+Extensions.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 23.01.2019.
//  Copyright © 2019 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManager

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
    /// Add padding view with fixed width/height to `UIStackView` instance.
    ///
    /// - Parameter value: Value for width/height for padding.
    /// - Returns: `UIView` for padding.
    func addEmptyViewWithFixedValue(_ value: CGFloat) -> UIView {
        let paddingView = UIView()
        paddingView.backgroundColor = .clear
        addArrangedSubview(paddingView)
        switch self.axis {
        case .horizontal:
            paddingView.snp.makeConstraints { maker in
                maker.width.equalTo(value)
            }
        case .vertical:
            paddingView.snp.makeConstraints { maker in
                maker.height.equalTo(value)
            }
        }
        
        return paddingView
    }
    
    /// Build an instance of `UIStackView` with embeded view and paddings.
    ///
    /// - Parameters:
    ///   - view: `UIView` instance to be ebmedded.
    ///   - axis: `NSLayoutConstraint.Axis` for axis.
    ///   - sidePadding: `CGFloat` value for paddings.
    /// - Returns: `UIStackView` instance.
    static func buildStackViewWithView(_ view: UIView, axis: NSLayoutConstraint.Axis, sidePadding: CGFloat) -> UIStackView {
        let stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = axis
            stackView.distribution = .fill
            stackView.alignment = .fill
            stackView.isLayoutMarginsRelativeArrangement = true
            return stackView
        }()
        
        stackView.addEmptyViewWithFixedValue(sidePadding)
        stackView.addArrangedSubview(view)
        stackView.addEmptyViewWithFixedValue(sidePadding)
        
        return stackView
    }
    
    func addArrangedSubviewWithFixedValue(_ subview: UIView, value: CGFloat) {
        addArrangedSubview(subview)
        switch self.axis {
        case .horizontal:
            subview.snp.makeConstraints { maker in
                maker.width.equalTo(value)
            }
        case .vertical:
            subview.snp.makeConstraints { maker in
                maker.height.equalTo(value)
            }
        }
    }
}
