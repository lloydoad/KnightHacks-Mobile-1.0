//
//  EventItemCell.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 9/1/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

class EventItemCell: UITableViewCell {
    static var identifier = "EventItemCell"
    var customBackgroundView: UIView!
    var eventNameLabel: UILabel!
    var eventLocationLabel: UILabel!
    var eventTimeLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        let ySpacing: CGFloat = 6
        let xSpacing: CGFloat = 21
        customBackgroundView = UIView()
        customBackgroundView.backgroundColor = .white
        customBackgroundView.layer.shadowColor = UIColor.black.cgColor
        customBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        customBackgroundView.layer.shadowRadius = 4
        customBackgroundView.layer.cornerRadius = 14
        customBackgroundView.layer.shadowOpacity = 1
        customBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(customBackgroundView)
        customBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ySpacing).isActive = true
        customBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ySpacing).isActive = true
        customBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: xSpacing).isActive = true
        customBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -xSpacing).isActive = true
        
        eventTimeLabel = UILabel()
        eventTimeLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        eventTimeLabel.text = "XX:XXxx"
        eventTimeLabel.textAlignment = .right
        customBackgroundView.addSubview(eventTimeLabel)
        
        eventTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        eventTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        eventTimeLabel.widthAnchor.constraint(equalToConstant: 87).isActive = true
        eventTimeLabel.trailingAnchor.constraint(equalTo: customBackgroundView.trailingAnchor, constant: -12).isActive = true
        eventTimeLabel.topAnchor.constraint(equalTo: customBackgroundView.topAnchor, constant: 12).isActive = true
        
        eventNameLabel = UILabel()
        eventNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        eventNameLabel.text = "Example Event Title"
        eventNameLabel.textColor = BACKGROUND_COLOR
        eventNameLabel.textAlignment = .left
        customBackgroundView.addSubview(eventNameLabel)
        
        eventNameLabel.translatesAutoresizingMaskIntoConstraints = false
        eventNameLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        eventNameLabel.widthAnchor.constraint(equalToConstant: 210).isActive = true
        eventNameLabel.leadingAnchor.constraint(equalTo: customBackgroundView.leadingAnchor, constant: 12).isActive = true
        eventNameLabel.topAnchor.constraint(equalTo: customBackgroundView.topAnchor, constant: 12).isActive = true
        
        eventLocationLabel = UILabel()
        eventLocationLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        eventLocationLabel.text = "Example Event Location"
        eventLocationLabel.textAlignment = .left
        customBackgroundView.addSubview(eventLocationLabel)
        
        eventLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        eventLocationLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        eventLocationLabel.widthAnchor.constraint(equalToConstant: 210).isActive = true
        eventLocationLabel.leadingAnchor.constraint(equalTo: customBackgroundView.leadingAnchor, constant: 12).isActive = true
        eventLocationLabel.topAnchor.constraint(equalTo: eventNameLabel.bottomAnchor, constant: 4).isActive = true
        
    }
}
