//
//  ScheduleTableViewCell.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 6/25/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

internal class ScheduleTableViewCell: UITableViewCell {
    
    static let identifier: String = "ScheduleTableViewCell"
    
    @IBOutlet weak var customBackgroundView: UIView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var model: ScheduleModel? {
        didSet {
            guard let model = model else { return }
            eventTitleLabel.text = model.title
            timeLabel.text = model.time
            locationLabel.text = model.location
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSpecifiedShadow(customBackgroundView)
        eventTitleLabel.font = TITLE_FONT
        locationLabel.font = PARAGRAPH_FONT
        timeLabel.font = MAJOR_PARAGRAPH_FONT
        eventTitleLabel.textColor = BACKGROUND_COLOR
    }
}
