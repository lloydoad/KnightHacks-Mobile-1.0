//
//  DefaultDynamicTableViewCell.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 9/18/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

extension DynamicTableViewCell {
    func setupDefaultCellView() {
        createBackgroundView()
        
        let mainVerticalStack = UIStackView()
        mainVerticalStack.axis = .vertical
        mainVerticalStack.alignment = .fill
        mainVerticalStack.distribution = .fill
        mainVerticalStack.spacing = 8
        mainVerticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundViewWithShadow?.addSubview(mainVerticalStack)
        mainVerticalStack.topAnchor.constraint(equalTo: (backgroundViewWithShadow?.topAnchor)!, constant: backgroundInnerMargin).isActive = true
        mainVerticalStack.bottomAnchor.constraint(equalTo: (backgroundViewWithShadow?.bottomAnchor)!, constant: -backgroundInnerMargin).isActive = true
        mainVerticalStack.leadingAnchor.constraint(equalTo: (backgroundViewWithShadow?.leadingAnchor)!, constant: backgroundInnerMargin).isActive = true
        mainVerticalStack.trailingAnchor.constraint(equalTo: (backgroundViewWithShadow?.trailingAnchor)!, constant: -backgroundInnerMargin).isActive = true
        
        let innerHorizontalStack = UIStackView()
        innerHorizontalStack.axis = .horizontal
        innerHorizontalStack.alignment = .center
        innerHorizontalStack.distribution = .fillProportionally
        innerHorizontalStack.spacing = 22
        innerHorizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel = createFormattedLabel(type: .title, defaultText: "Default Title", alignment: .left)
        timeLabel = createFormattedLabel(type: .majorParagraph, defaultText: "xx:xx am", alignment: .right)
        
        innerHorizontalStack.addArrangedSubview(titleLabel!)
        innerHorizontalStack.addArrangedSubview(timeLabel!)
        mainVerticalStack.addArrangedSubview(innerHorizontalStack)
        
        locationLabel = createFormattedLabel(type: .paragraph, defaultText: "Lorem ipsum dolor sit", alignment: .left)
        mainVerticalStack.addArrangedSubview(locationLabel!)
    }
}

