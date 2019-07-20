//
//  ViewHelperBuilder.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 7/20/19.
//  Copyright © 2019 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManager

final class ViewHelperBuilder {
    
    static func buildScrollView() -> UIScrollView {
        let scrollView = UIScrollView.init()
        scrollView.showsVerticalScrollIndicator = false
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        return scrollView
    }
    
    static func buildStackViewWithAxis(_ axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }
    
    static func buildImageView() -> UIImageView {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        return imgView
    }
    
    static func setupStackViewScrollInView(_ view: UIView, stackView: UIStackView, scrollView: UIScrollView) {
        view.addSubview(scrollView)
        
        // for handling text inputs
        let contentView = IQPreviousNextView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make -> Void in
            if #available(iOS 11.0, *) {
                make.left.right.top.bottom.equalTo(view.safeAreaLayoutGuide)
            } else {
                make.top.equalToSuperview()
                make.left.right.bottom.equalToSuperview()
            }
        }
        
        contentView.constraintToSuperviewEdges()
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { maker in
            maker.width.equalTo(scrollView)
        }
    }
}
