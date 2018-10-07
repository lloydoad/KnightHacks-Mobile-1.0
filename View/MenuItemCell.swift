//
//  MenuItemCell.swift
//  KnightHacks
//
//  Created by KnightHacks on 8/26/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit
import Foundation

class MenuItemTableViewCell: UITableViewCell {
    static var identifier = "MenuItemTableViewCell"
    var customTitleLabel: UILabel!
    var customIconView: UIImageView!
    var customBackground: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        let margins: CGFloat = 15
        let spacing: CGFloat = 5
        
        // control the spacing between cells and screen edges
        customBackground = UIView()
        customBackground.layer.cornerRadius = 14
        customBackground.translatesAutoresizingMaskIntoConstraints = false
        customBackground.backgroundColor = .white
        customBackground.layer.shadowColor = UIColor(hex: 0x000000, alpha: 0.5).cgColor
        customBackground.layer.shadowOffset = CGSize(width: 0, height: 0)
        customBackground.layer.shadowRadius = 6
        contentView.addSubview(customBackground)
        customBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing).isActive = true
        customBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spacing).isActive = true
        customBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margins).isActive = true
        customBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                 constant: (margins - (2 * margins))).isActive = true
        
        setupViewDetails(customBackground)
    }
    
    // setup the label and icon in each cell
    func setupViewDetails(_ wall: UIView) {
        // Assuming 24 lato font will fit inside a 190x40
        customTitleLabel = UILabel()
        customTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        customTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        customTitleLabel.textColor = UIColor.white
        wall.addSubview(customTitleLabel)
        customTitleLabel.widthAnchor.constraint(equalToConstant: 190).isActive = true
        customTitleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        customTitleLabel.leadingAnchor.constraint(equalTo: wall.leadingAnchor, constant: 17).isActive = true
        customTitleLabel.topAnchor.constraint(equalTo: wall.topAnchor, constant: 10).isActive = true
        
        // assuming 96 height amd 96 width would fit all icons
        let length: CGFloat = 96
        customIconView = UIImageView()
        customIconView.contentMode = .scaleAspectFit
        customIconView.backgroundColor = .clear
        customIconView.translatesAutoresizingMaskIntoConstraints = false
        wall.addSubview(customIconView)
        customIconView.heightAnchor.constraint(equalToConstant: length).isActive = true
        customIconView.widthAnchor.constraint(equalToConstant: length).isActive = true
        customIconView.centerYAnchor.constraint(equalTo: wall.centerYAnchor).isActive = true
        customIconView.trailingAnchor.constraint(equalTo: wall.trailingAnchor, constant: -14).isActive = true
    }
    
    // fade out cell when highlighted
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        let baseColor = customBackground.backgroundColor?.rgba
        
        // changes on touch and release
        if highlighted {
            customBackground.backgroundColor = UIColor(red: baseColor!.red, green: baseColor!.green, blue: baseColor!.blue, alpha: 0.65)
        } else {
            customBackground.backgroundColor = UIColor(red: baseColor!.red, green: baseColor!.green, blue: baseColor!.blue, alpha: 1)
        }
    }
}









