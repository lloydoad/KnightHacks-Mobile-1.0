//
//  menuItemTableViewCell.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 8/26/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit
import Foundation

class menuItemTableViewCell: UITableViewCell {
    static var identifier = "MenuItemTableViewCell"
    var customColor: UIColor!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        let redColor: CGFloat = CGFloat(arc4random() % 255)
        let greenColor: CGFloat = CGFloat(arc4random() % 255)
        let blueColor: CGFloat = CGFloat(arc4random() % 255)
        let margins: CGFloat = 15
        let spacing: CGFloat = 5
        
        customColor = UIColor(red: redColor/255, green: greenColor/255, blue: blueColor/255, alpha: 1)
        
        let backgroundView = UIView()
        backgroundView.layer.cornerRadius = 14
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = customColor
        contentView.addSubview(backgroundView)
        backgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spacing).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margins).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                 constant: (margins - (2 * margins))).isActive = true
        
    }
}
