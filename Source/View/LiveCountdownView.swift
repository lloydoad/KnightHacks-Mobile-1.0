//
//  LiveCountdownView.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/23/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

/**
 A view for displaying live countdown timer to specified time
 */
public class LiveCountdownView: UIView {
    
    public static let nibName: String = "LiveCountdownView"

    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var countdownTitleLabel: UILabel!
    @IBOutlet private weak var countdownLabel: UILabel!
    @IBOutlet private weak var countdownSubscriptLabel: UILabel!
    @IBOutlet private weak var isLiveIndicatorLabel: UILabel!
    
    private var timeToEnd: Int = 0
    private var currentTimeString: (Int, Int, Int) = (0, 0, 0)
    
    public var isLive: Bool? {
        didSet {
            guard let isLive = isLive else { return }
            if isLive {
                isLiveIndicatorLabel.backgroundColor = RED_COLOR
            } else {
                isLiveIndicatorLabel.backgroundColor = UIColor.gray
            }
        }
    }
    
    public var title: String? {
        didSet {
            countdownTitleLabel.text = title
        }
    }
    
    public var titleSubscript: String? {
        didSet {
            countdownSubscriptLabel.text = titleSubscript
        }
    }
    
    public var targetEndDate: Date? {
        didSet {
            if let targetEndData = targetEndDate {
                start(date: targetEndData)
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    private func initView() {
        Bundle.main.loadNibNamed(LiveCountdownView.nibName, owner: self, options: nil)
        addSubview(contentView)
        backgroundColor = BACKGROUND_COLOR
        contentView.frame = bounds
        contentView.backgroundColor = BACKGROUND_COLOR
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func start(date: Date) {
        isLive = true
        timeToEnd = Int(date.timeIntervalSince1970 - Date().timeIntervalSince1970)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: isLive ?? false)
    }
    
    @objc private func updateTimer() {

        guard timeToEnd > 0 else {
            countdownLabel.text = "00:00:00"
            isLive = false
            return
        }
        
        currentTimeString = intervalToHoursMinutesSeconds(seconds: timeToEnd)
        timeToEnd -= 1
        countdownLabel.text = String(format: "%02d:%02d:%02d", currentTimeString.0, currentTimeString.1, currentTimeString.2)
    }
    
    private func intervalToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
