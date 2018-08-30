//
//  FilterButtonCollectionViewCell.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 8/29/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

class FilterButtonCollectionViewCell: UICollectionViewCell {
    static var identifier = "FilterButtonCollectionViewCell"
    var customBackgroundView: UIView!
    var customBackgroundShadow: UIView!
    var customText: UILabel!
    var customImage: UIImage!
    var customLabel: UILabel!
    let backgroundDiameter: CGFloat = 85
    let borderThickness: CGFloat = 3
    
    // inits
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        customLabel.text = "TEST TEST"
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
        customBackgroundView = makeCustomView(width: innerCircleDiameter, height: innerCircleDiameter)
        customBackgroundView.layer.borderColor = BACKGROUND_COLOR.cgColor
        customBackgroundView.layer.borderWidth = borderThickness
        customBackgroundShadow.addSubview(customBackgroundView)
        customBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        customBackgroundView.centerXAnchor.constraint(equalTo: customBackgroundShadow.centerXAnchor).isActive = true
        customBackgroundView.centerYAnchor.constraint(equalTo: customBackgroundShadow.centerYAnchor).isActive = true
        customBackgroundView.widthAnchor.constraint(equalToConstant: innerCircleDiameter).isActive = true
        customBackgroundView.heightAnchor.constraint(equalToConstant: innerCircleDiameter).isActive = true
    }
    
    // Change borders and circumference when selected
    override var isSelected: Bool {
        didSet {
            if isSelected {
                customBackgroundView.layer.borderWidth = borderThickness
                customBackgroundShadow.backgroundColor = .white
            } else {
                customBackgroundView.layer.borderWidth = 0
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

