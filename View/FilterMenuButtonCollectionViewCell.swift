//
//  FilterButtonCollectionViewCell.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 8/29/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

class FilterMenuButtonCollectionViewCell: UICollectionViewCell {
    static var identifier = "FilterButtonCollectionViewCell"
    var customBackgroundShadow: UIView!
    var customText: UILabel!
    var customImage: UIView!
    var customLabel: UILabel!
    var insetImageContainer: UIImageView!
    let backgroundDiameter: CGFloat = 85
    let borderThickness: CGFloat = 3
    
    // inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 2
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2).isActive = true
        
        // NOTE cutoff point for label
        customLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 14))
        customLabel.backgroundColor = .clear
        customLabel.text = "NO LABEL"
        customLabel.textColor = .white
        customLabel.textAlignment = .center
        customLabel.font = UIFont.systemFont(ofSize: 14)
        customLabel.translatesAutoresizingMaskIntoConstraints = false
        
        customBackgroundShadow = makeCustomView(width: backgroundDiameter, height: backgroundDiameter)
        customBackgroundShadow.widthAnchor.constraint(equalToConstant: backgroundDiameter).isActive = true
        customBackgroundShadow.heightAnchor.constraint(equalToConstant: backgroundDiameter).isActive = true
        
        stackView.addArrangedSubview(customBackgroundShadow)
        stackView.addArrangedSubview(customLabel)
        
        let innerCircleDiameter = backgroundDiameter - borderThickness
        customImage = UIView()
        customImage.translatesAutoresizingMaskIntoConstraints = false
        customImage.backgroundColor = .white
        customImage.layer.cornerRadius = innerCircleDiameter / 2
        customImage.layer.borderColor = BACKGROUND_COLOR.cgColor
        customImage.layer.borderWidth = borderThickness
        customImage.layoutMargins = UIEdgeInsetsMake(20, 20, 20, 20)
        customImage.clipsToBounds = true
        
        customBackgroundShadow.addSubview(customImage)
        customImage.heightAnchor.constraint(equalToConstant: innerCircleDiameter).isActive = true
        customImage.widthAnchor.constraint(equalToConstant: innerCircleDiameter).isActive = true
        customImage.centerYAnchor.constraint(equalTo: customBackgroundShadow.centerYAnchor).isActive = true
        customImage.centerXAnchor.constraint(equalTo: customBackgroundShadow.centerXAnchor).isActive = true
        
        insetImageContainer = UIImageView()
        insetImageContainer.translatesAutoresizingMaskIntoConstraints = false
        insetImageContainer.backgroundColor = .white
        insetImageContainer.contentMode = .scaleAspectFit
        customImage.addSubview(insetImageContainer)
        insetImageContainer.heightAnchor.constraint(equalToConstant: 45).isActive = true
        insetImageContainer.widthAnchor.constraint(equalToConstant: 45).isActive = true
        insetImageContainer.centerYAnchor.constraint(equalTo: customImage.centerYAnchor).isActive = true
        insetImageContainer.centerXAnchor.constraint(equalTo: customImage.centerXAnchor).isActive = true
    }
    
    // Change borders and circumference when selected
    override var isSelected: Bool {
        didSet {
            if isSelected {
                customImage.layer.borderWidth = borderThickness
                customBackgroundShadow.backgroundColor = .white
            } else {
                customImage.layer.borderWidth = 0
                customBackgroundShadow.backgroundColor = .clear
            }
        }
    }
    
    // Convenient function for making circular views
    func makeCustomView(width: CGFloat, height: CGFloat) -> UIView {
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        myView.backgroundColor = .white
        myView.layer.shadowColor = UIColor.black.cgColor
        myView.layer.shadowOffset = CGSize(width: 0, height: 1)
        myView.layer.shadowRadius = 4
        myView.layer.cornerRadius = height / 2
        return myView
    }
}

