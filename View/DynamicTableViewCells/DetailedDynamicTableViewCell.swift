//
//  DetailedDynamicTableViewCell.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 9/18/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

extension DynamicTableViewCell {
    func setupDetailedCellView() {
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
        
        contentImageView = UIImageView()
        contentImageView!.backgroundColor = .clear
        contentImageView!.translatesAutoresizingMaskIntoConstraints = false
        contentImageView!.heightAnchor.constraint(equalToConstant: largeImageSideLength).isActive = true
        contentImageView!.contentMode = .scaleAspectFit
        
        let innerHorizontalStack = UIStackView()
        innerHorizontalStack.axis = .horizontal
        innerHorizontalStack.alignment = .center
        innerHorizontalStack.distribution = .fill
        innerHorizontalStack.spacing = 22
        innerHorizontalStack.translatesAutoresizingMaskIntoConstraints = false
        titleLabel = createFormattedLabel(type: .title, defaultText: "Default Title", alignment: .left)
        if hasRegularRightDetail {
            timeLabel = createFormattedLabel(type: .paragraph, defaultText: "default default", alignment: .left)
            titleLabel?.translatesAutoresizingMaskIntoConstraints = false
            titleLabel?.widthAnchor.constraint(lessThanOrEqualToConstant: 120).isActive = true
        } else {
            timeLabel = createFormattedLabel(type: .majorParagraph, defaultText: "xx:xx xx", alignment: .right)
        }
        innerHorizontalStack.addArrangedSubview(titleLabel!)
        innerHorizontalStack.addArrangedSubview(timeLabel!)
        
        itemDescriptionLabel = createFormattedLabel(type: .paragraph, defaultText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin", alignment: .left)
        itemTagLabel = createFormattedLabel(type: .minorParagraph, defaultText: "default tag", alignment: .left)
        itemTagLabel?.textColor = UIColor(hex: 0x26AE60, alpha: 1)
        
        mainVerticalStack.addArrangedSubview(contentImageView!)
        mainVerticalStack.addArrangedSubview(innerHorizontalStack)
        if hasUpperTags {
            let horizontalStack = UIStackView()
            horizontalStack.axis = .horizontal
            horizontalStack.alignment = .leading
            horizontalStack.distribution = .fill
            horizontalStack.spacing = 10
            horizontalStack.translatesAutoresizingMaskIntoConstraints = false
            mainVerticalStack.addArrangedSubview(horizontalStack)
            horizontalStack.addArrangedSubview(createTagInView())
            horizontalStack.addArrangedSubview(createTagInView())
            horizontalStack.addArrangedSubview(UIView())
        }
        mainVerticalStack.addArrangedSubview(itemDescriptionLabel!)
        if !hasUpperTags { mainVerticalStack.addArrangedSubview(itemTagLabel!) }
    }
}
