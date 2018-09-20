//
//  LiveUpdateCountdownTimerViewController.swift
//  KH_prototype_one
//
//  Created by Haerunnisa Dewindita on 9/18/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

class LiveUpdateCountdownTimerViewController: UIView {
    var stackView: UIStackView!
    var titleStackView: UIStackView!
    var title: UILabel!
    var liveIndicatorLabelBackground: UIView!
    var liveIndicatorLabel: UILabel!
    var countdownTimer: UILabel!
    var countdownTimerSubtitle: UILabel!
    var isCountdownLive: Bool!
    
    var timer: Timer!
    var currentTime: Date!
    var targetTime: Date!
    var timeIntervalInSeconds = 0
    var countdownHours = 0
    var countdownMinutes = 0
    var countdownSeconds = 0
    
    let LIVE_INDICATOR_TEXT = "Live"
    let LIVE_INDICATOR_SUBTITLE = "until hacking ends"
    let DEFAULT_COUNTDOWN_TIME = "00:00:00"
    let LIVE_INDICATOR_CORNER_RADIUS = CGFloat(integerLiteral: 7)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isCountdownLive = true
        
        setupTitle(frame: frame)
        setupCountdownUI()
        setupCountdown()
        runTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupTitle(frame: CGRect) {
        stackView = UIStackView(frame: frame)
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.axis = .vertical
        stackView.alignment  = .center
        
        titleStackView = UIStackView(frame: frame)
        stackView.addArrangedSubview(titleStackView)
        titleStackView.axis = .horizontal
        titleStackView.alignment = .center
        titleStackView.spacing = 15
        
        title = UILabel()
        titleStackView.addArrangedSubview(title)
        title.font = BIG_HEADER_FONT
        title.text = APP_EVENT_NAME
        title.textColor = .white
        
        if isCountdownLive {
            liveIndicatorLabelBackground = UIView()
            titleStackView.addArrangedSubview(liveIndicatorLabelBackground)
            liveIndicatorLabelBackground.backgroundColor = UIColor.red
            liveIndicatorLabelBackground.layer.cornerRadius = LIVE_INDICATOR_CORNER_RADIUS
            liveIndicatorLabelBackground.translatesAutoresizingMaskIntoConstraints = false
            liveIndicatorLabelBackground.widthAnchor.constraint(equalToConstant: 75).isActive = true
            liveIndicatorLabelBackground.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            liveIndicatorLabel = UILabel(frame: CGRect(x: 5, y: 0, width: 75, height: 40))
            liveIndicatorLabelBackground.addSubview(liveIndicatorLabel)
            liveIndicatorLabel.text = LIVE_INDICATOR_TEXT
            liveIndicatorLabel.font = BIG_HEADER_FONT
            liveIndicatorLabel.textColor = .white
        }
    }
    
    func setupCountdownUI() {
        countdownTimer = UILabel()
        stackView.addArrangedSubview(countdownTimer)
        countdownTimer.translatesAutoresizingMaskIntoConstraints = false
        countdownTimer.topAnchor.constraint(equalTo: titleStackView.bottomAnchor).isActive = true
        countdownTimer.text = DEFAULT_COUNTDOWN_TIME
        countdownTimer.textColor = .white
        countdownTimer.font = BIG_ULTRA_LIGHT_HEADER_FONT
        
        countdownTimerSubtitle = UILabel()
        stackView.addArrangedSubview(countdownTimerSubtitle)
        countdownTimerSubtitle.text = LIVE_INDICATOR_SUBTITLE
        countdownTimerSubtitle.textColor = .white
        countdownTimerSubtitle.font = LIGHT_TITLE_FONT
    }
    
    func secondsToHoursMinutesSeconds(seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }

    func setupCountdown() {
        timer = Timer()
        currentTime = Date()
        
        // Temporarily use a target time always some hours ahead of current time
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DATE_STRING_FORMAT
        let dummyStartDate = dateFormatter.string(from: currentTime.addingTimeInterval(TimeInterval(48.0 * 60.0 * 60.0)))
        
        targetTime = dateFormatter.date(from: dummyStartDate)

        if targetTime.timeIntervalSince(currentTime).isLess(than: 0) {
            return
        }
        
        timeIntervalInSeconds = Int(DateInterval(start: currentTime, end: targetTime).duration)
        (countdownHours, countdownMinutes, countdownSeconds) = secondsToHoursMinutesSeconds(seconds: timeIntervalInSeconds)
    }
    
    func runTimer() {
        if !isCountdownLive {
            return
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if timeIntervalInSeconds < 1 || !isCountdownLive {
            return
        }

        timeIntervalInSeconds -= 1
        (countdownHours, countdownMinutes, countdownSeconds) = secondsToHoursMinutesSeconds(seconds: timeIntervalInSeconds)
        
        countdownTimer.text = String(format: "%02d:%02d:%02d", countdownHours, countdownMinutes, countdownSeconds)
    }
}
