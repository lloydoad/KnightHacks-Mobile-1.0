//
//  LeftImageDynamicTableViewCell.swift
//  KnightHacks
//
//  Created by KnightHacks on 9/18/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

extension DynamicTableViewCell {
    func setupLeftImageCellView() {
        createBackgroundView()
        createLeftImageUIElements()
        setConstraintForLeftImageUIElements()
    }
    
    func createLeftImageUIElements() {
        contentImageView = UIImageView()
        contentImageView!.backgroundColor = .clear
        contentImageView!.contentMode = .scaleAspectFit
        
        itemDescriptionLabel = createFormattedLabel(type: .paragraph, defaultText: "Lorem ipsum dolor sit. Lorem ipsum dolor sit.", alignment: .left)
        itemDescriptionLabel?.numberOfLines = 0
        timeLabel = createFormattedLabel(type: .minorParagraph, defaultText: "9:15pm - 29m ago", alignment: .left)
    }
    
    func setConstraintForLeftImageUIElements() {
        contentImageView!.translatesAutoresizingMaskIntoConstraints = false
        contentImageView!.heightAnchor.constraint(equalToConstant: imageSideLength).isActive = true
        contentImageView!.widthAnchor.constraint(equalToConstant: imageSideLength).isActive = true
        
        let horizontalStack = getPresetUIStackView(axis: .horizontal, alignment: .center, distribution: .fill, spacing: 22)
        
        let insets = UIEdgeInsets(top: backgroundInnerMargin, left: backgroundInnerMargin, bottom: -backgroundInnerMargin, right: -backgroundInnerMargin)
        boundEdges(of: horizontalStack, to: backgroundViewWithShadow!, with: insets)
        
        horizontalStack.addArrangedSubview(contentImageView!)
        
        let labelVerticalStack = getPresetUIStackView(axis: .vertical, alignment: .fill, distribution: .fill, spacing: 4)
        
        labelVerticalStack.addArrangedSubview(itemDescriptionLabel!)
        labelVerticalStack.addArrangedSubview(timeLabel!)
        horizontalStack.addArrangedSubview(labelVerticalStack)
    }
}
