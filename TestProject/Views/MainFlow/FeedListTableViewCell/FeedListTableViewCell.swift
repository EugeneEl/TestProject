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
    
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var dateLabel: UILabel!
    @IBOutlet fileprivate weak var summaryLabel: UILabel!
    @IBOutlet fileprivate weak var linkLabel: UILabel!
    
    // MARK: - Vars
    
    weak var delegate: FeedListTableViewCellInteractable?
    
    // MARK: - Actions
    
    @IBAction fileprivate func linkDidTap() {
        delegate?.linkDidTapInCell(self)
    }
}

// MARK: - DataObjectConfigurable

extension FeedListTableViewCell: DataObjectConfigurable {
    typealias DataObject = FeedItemJSONModel
    
    func configureWithObject(_ object: FeedItemJSONModel) {
        titleLabel.text = object.headline
        summaryLabel.text = object.summary
        print("object.summary: \(object.summary)")
        linkLabel.text = object.url.absoluteString
        dateLabel.text = FeedListCellPresenter.provideDateTextForFeedItem(object)
    }
}
