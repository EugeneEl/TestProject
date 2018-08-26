//
//  FeedListTableViewCell.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 18.04.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

protocol FeedListTableViewCellInteractable: class {
    func linkDidTapInCell(_ cell: FeedListTableViewCell)
}

class FeedListTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet fileprivate weak var containerView: UIView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var dateLabel: UILabel!
    @IBOutlet fileprivate weak var summaryLabel: UILabel!
    @IBOutlet fileprivate weak var linkLabel: UILabel!
    
    // MAKR: - Constants
    
    fileprivate static let shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
    fileprivate static let shadowRadius: CGFloat = 4
    fileprivate static let shadowOffset: CGSize = CGSize(width: 0, height: 2)
    
    // MARK: - Vars
    
    weak var delegate: FeedListTableViewCellInteractable?
    
    // MARK: - Override
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = Constants.Colors.grey
        addShadow()
    }
    
    // MARK: - Actions
    
    @IBAction fileprivate func linkDidTap() {
        delegate?.linkDidTapInCell(self)
    }
}

// MARK: - DataObjectConfigurable

extension FeedListTableViewCell: DataObjectConfigurable {
    typealias DataObject = FeedItem
    
    func configureWithObject(_ object: FeedItem) {
        titleLabel.text = object.headline
        summaryLabel.text = object.summary
        print("object.summary: \(object.summary)")
        linkLabel.text = object.url.absoluteString
        dateLabel.text = FeedListCellPresenter.provideDateTextForFeedItem(object)
    }
    
    fileprivate func addShadow() {
        containerView.layer.shadowColor = FeedListTableViewCell.shadowColor
        containerView.layer.shadowRadius = FeedListTableViewCell.shadowRadius
        containerView.layer.shadowOffset = FeedListTableViewCell.shadowOffset
        containerView.layer.shadowOpacity = 1
        containerView.layer.masksToBounds = false
    }
}
