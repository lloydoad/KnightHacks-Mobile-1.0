//
//  DetailedDynamicTableViewCell.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 9/18/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

extension DynamicTableViewCell {
    func setupDetailedCellView() {
        createBackgroundView()
        createDetailUIElements()
        setConstraintForDetailUIElements()
    }
    
    func createDetailUIElements() {
        contentImageView = UIImageView()
        contentImageView!.backgroundColor = .clear
        contentImageView!.contentMode = .scaleAspectFit
        
        titleLabel = createFormattedLabel(type: .title, defaultText: "Default Title", alignment: .left)
        if isTimeStampMinimized && cellType == .detailedCell {
            timeLabel = createFormattedLabel(type: .paragraph, defaultText: "default default", alignment: .left)
        } else {
            timeLabel = createFormattedLabel(type: .majorParagraph, defaultText: "xx:xx xx", alignment: .right)
        }
        
        itemDescriptionLabel = createFormattedLabel(type: .paragraph, defaultText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin", alignment: .left)
        itemTagLabel = createFormattedLabel(type: .minorParagraph, defaultText: "default tag", alignment: .left)
        itemTagLabel?.textColor = UIColor(hex: 0x26AE60, alpha: 1)
    }
    
    func setConstraintForDetailUIElements() {
        let mainVerticalStack = getPresetUIStackView(axis: .vertical, alignment: .fill, distribution: .fill, spacing: 8)
        
        let insets = UIEdgeInsets(top: backgroundInnerMargin, left: backgroundInnerMargin, bottom: -backgroundInnerMargin, right: -backgroundInnerMargin)
        boundEdges(of: mainVerticalStack, to: self.backgroundViewWithShadow!, with: insets)
        
        contentImageView!.translatesAutoresizingMaskIntoConstraints = false
        contentImageView!.heightAnchor.constraint(equalToConstant: largeImageSideLength).isActive = true
        mainVerticalStack.addArrangedSubview(contentImageView!)
        
        let innerHorizontalStack = getPresetUIStackView(axis: .horizontal, alignment: .center, distribution: .fill, spacing: 22)
        
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.widthAnchor.constraint(lessThanOrEqualToConstant: 120).isActive = true
        innerHorizontalStack.addArrangedSubview(titleLabel!)
        innerHorizontalStack.addArrangedSubview(timeLabel!)
        mainVerticalStack.addArrangedSubview(innerHorizontalStack)
        
        horizontalTagStack = getPresetUIStackView(axis: .horizontal, alignment: .leading, distribution: .fill, spacing: 10)
        
        if hasUpperTags && cellType == .detailedCell {
            mainVerticalStack.addArrangedSubview(horizontalTagStack!)
            horizontalTagStack!.addArrangedSubview(UIView())
        }
        
        mainVerticalStack.addArrangedSubview(itemDescriptionLabel!)
        
        if !hasUpperTags && cellType == .detailedCell {
            mainVerticalStack.addArrangedSubview(horizontalTagStack!)
            horizontalTagStack!.addArrangedSubview(UIView())
        }
    }
}
