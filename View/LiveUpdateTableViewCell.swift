//
//  LiveUpdateTableViewCell.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 9/18/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

class LiveUpdatesTableViewCell: UITableViewCell {
    static let identifier = "LiveUpdatesTableViewCell"
    var liveUpdatesView: UIView? {
        didSet {
            setupView()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = BACKGROUND_COLOR
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        if liveUpdatesView != nil {
            liveUpdatesView?.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(liveUpdatesView!)
            
            liveUpdatesView?.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            liveUpdatesView?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            liveUpdatesView?.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            liveUpdatesView?.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        }
    }
}
