//
//  LeftImageDynamicTableViewCell.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 9/18/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

extension DynamicTableViewCell {
    func setupLeftImageCellView() {
        createBackgroundView()
        
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.distribution = .fill
        horizontalStack.spacing = 22
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundViewWithShadow?.addSubview(horizontalStack)
        horizontalStack.topAnchor.constraint(equalTo: (backgroundViewWithShadow?.topAnchor)!, constant: backgroundInnerMargin).isActive = true
        horizontalStack.bottomAnchor.constraint(equalTo: (backgroundViewWithShadow?.bottomAnchor)!, constant: -backgroundInnerMargin).isActive = true
        horizontalStack.leadingAnchor.constraint(equalTo: (backgroundViewWithShadow?.leadingAnchor)!, constant: backgroundInnerMargin).isActive = true
        horizontalStack.trailingAnchor.constraint(equalTo: (backgroundViewWithShadow?.trailingAnchor)!, constant: -backgroundInnerMargin).isActive = true
        
        contentImageView = UIImageView()
        contentImageView!.backgroundColor = .clear
        contentImageView!.translatesAutoresizingMaskIntoConstraints = false
        contentImageView!.heightAnchor.constraint(equalToConstant: imageSideLength).isActive = true
        contentImageView!.widthAnchor.constraint(equalToConstant: imageSideLength).isActive = true
        contentImageView!.contentMode = .scaleAspectFit
        
        itemDescriptionLabel = createFormattedLabel(type: .paragraph, defaultText: "Lorem ipsum dolor sit. Lorem ipsum dolor sit.", alignment: .left)
        itemDescriptionLabel?.numberOfLines = 0
        timeLabel = createFormattedLabel(type: .minorParagraph, defaultText: "9:15pm - 29m ago", alignment: .left)
        
        horizontalStack.addArrangedSubview(contentImageView!)
        
        let mainVerticalStack = UIStackView()
        mainVerticalStack.axis = .vertical
        mainVerticalStack.alignment = .fill
        mainVerticalStack.distribution = .fill
        mainVerticalStack.spacing = 4
        mainVerticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        mainVerticalStack.addArrangedSubview(itemDescriptionLabel!)
        mainVerticalStack.addArrangedSubview(timeLabel!)
        
        horizontalStack.addArrangedSubview(mainVerticalStack)
    }
}
