//
//  FilterButtonCollectionViewCell.swift
//  KnightHacks
//
//  Created by KnightHacks on 8/29/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

class FilterMenuButtonCollectionViewCell: UICollectionViewCell {
    static var identifier = "FilterButtonCollectionViewCell"
    
    let backgroundDiameter: CGFloat = 85
    let borderThickness: CGFloat = 3
    let labelWidth: CGFloat = 70
    let labelHeight: CGFloat = 14
    let imagePadding: CGFloat = 20
    let defaultText: String = "NO LABEL"
    
    var filterMenuButtonBackgroundShadow: UIView!
    var filterMenuButtonExteriorBorderView: UIView!
    var filterMenuButtonLabel: UILabel!
    var filterMenuButtonImageView: UIImageView!
    var innerCircleDiameter: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        
        innerCircleDiameter = backgroundDiameter - borderThickness
        createViewElements()
        setConstraintsForViewElements()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createViewElements() {
        filterMenuButtonLabel = UILabel(frame: CGRect(x: 0, y: 0, width: labelWidth, height: labelHeight))
        filterMenuButtonLabel.backgroundColor = .clear
        filterMenuButtonLabel.text = defaultText
        filterMenuButtonLabel.textColor = .white
        filterMenuButtonLabel.textAlignment = .center
        filterMenuButtonLabel.font = PARAGRAPH_FONT
        filterMenuButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        filterMenuButtonExteriorBorderView = UIView()
        filterMenuButtonExteriorBorderView.translatesAutoresizingMaskIntoConstraints = false
        filterMenuButtonExteriorBorderView.backgroundColor = .white
        filterMenuButtonExteriorBorderView.layer.cornerRadius = innerCircleDiameter / 2
        filterMenuButtonExteriorBorderView.layer.borderColor = BACKGROUND_COLOR.cgColor
        filterMenuButtonExteriorBorderView.layer.borderWidth = borderThickness
        filterMenuButtonExteriorBorderView.layoutMargins = UIEdgeInsetsMake(imagePadding, imagePadding, imagePadding, imagePadding)
        filterMenuButtonExteriorBorderView.clipsToBounds = true
        
        filterMenuButtonImageView = UIImageView()
        filterMenuButtonImageView.translatesAutoresizingMaskIntoConstraints = false
        filterMenuButtonImageView.backgroundColor = .white
        filterMenuButtonImageView.contentMode = .scaleAspectFit
    }
    
    func setConstraintsForViewElements() {
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
        
        filterMenuButtonBackgroundShadow = makeCustomView(width: backgroundDiameter, height: backgroundDiameter)
        filterMenuButtonBackgroundShadow.widthAnchor.constraint(equalToConstant: backgroundDiameter).isActive = true
        filterMenuButtonBackgroundShadow.heightAnchor.constraint(equalToConstant: backgroundDiameter).isActive = true
        
        stackView.addArrangedSubview(filterMenuButtonBackgroundShadow)
        stackView.addArrangedSubview(filterMenuButtonLabel)
        
        filterMenuButtonBackgroundShadow.addSubview(filterMenuButtonExteriorBorderView)
        filterMenuButtonExteriorBorderView.heightAnchor.constraint(equalToConstant: innerCircleDiameter).isActive = true
        filterMenuButtonExteriorBorderView.widthAnchor.constraint(equalToConstant: innerCircleDiameter).isActive = true
        filterMenuButtonExteriorBorderView.centerYAnchor.constraint(equalTo: filterMenuButtonBackgroundShadow.centerYAnchor).isActive = true
        filterMenuButtonExteriorBorderView.centerXAnchor.constraint(equalTo: filterMenuButtonBackgroundShadow.centerXAnchor).isActive = true
        
        filterMenuButtonExteriorBorderView.addSubview(filterMenuButtonImageView)
        filterMenuButtonImageView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        filterMenuButtonImageView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        filterMenuButtonImageView.centerYAnchor.constraint(equalTo: filterMenuButtonExteriorBorderView.centerYAnchor).isActive = true
        filterMenuButtonImageView.centerXAnchor.constraint(equalTo: filterMenuButtonExteriorBorderView.centerXAnchor).isActive = true
    }
    
    // change borders and circumference when selected
    override var isSelected: Bool {
        didSet {
            if isSelected {
                filterMenuButtonExteriorBorderView.layer.borderWidth = borderThickness
                filterMenuButtonBackgroundShadow.backgroundColor = .white
            } else {
                filterMenuButtonExteriorBorderView.layer.borderWidth = 0
                filterMenuButtonBackgroundShadow.backgroundColor = .clear
            }
        }
    }
    
    // convenient function for making circular views
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

