//
//  LiveUpdatesLargeTableViewCell.swift
//  KnightHacks
//
//  Created by Jamal Yauhari on 10/11/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

internal class LiveUpdatesLargeTableViewCell: UITableViewCell {
    
    public static let identifier: String = "LiveUpdatesLargeCellIdentifier"
    
    @IBOutlet weak var customBackgroundView: UIView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var model: LiveUpdateModel? {
        didSet {
            guard let model = model else { return }
            
            // set variables values.
            titleLabel.text = model.title
            timeLabel.text = "\(model.time) - \(timePassedString(intervalToHoursMinutesSeconds(model.date)))"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSpecifiedShadow(customBackgroundView)
        timeLabel.font = MINOR_PARAGRAPH_FONT
        titleLabel.font = PARAGRAPH_FONT
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {}
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
    
    private func intervalToHoursMinutesSeconds(_ date: Date) -> (Int, Int, Int) {
        let seconds = Int(Date().timeIntervalSince1970) - Int(date.timeIntervalSince1970)
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    private func timePassedString(_ hms: (Int, Int, Int)) -> String {
        if hms.0 > 0 {
            return "\(hms.0) hours ago"
        } else if hms.1 > 0 {
            return "\(hms.1) minutes ago"
        } else {
            return "\(hms.2) seconds ago"
        }
    }
}
