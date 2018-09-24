//
//  DefaultDynamicTableViewCell.swift
//  KnightHacks
//
//  Created by KnightHacks on 9/18/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

extension DynamicTableViewCell {
    func setupDefaultCellView() {
        createBackgroundView()
        createDefaultUIElements()
        setConstraintForDefaultUIElements()
    }
    
    func createDefaultUIElements() {
        titleLabel = createFormattedLabel(type: .title, defaultText: "Default Long Title", alignment: .left)
        timeLabel = createFormattedLabel(type: .majorParagraph, defaultText: "xx:xx am", alignment: .right)
        locationLabel = createFormattedLabel(type: .paragraph, defaultText: "Lorem ipsum dolor sit", alignment: .left)
    }
    
    func setConstraintForDefaultUIElements() {
        let mainVerticalStack = getPresetUIStackView(axis: .vertical, alignment: .fill, distribution: .fill, spacing: 8)
        
        let insets = UIEdgeInsets(top: backgroundInnerMargin, left: backgroundInnerMargin, bottom: -backgroundInnerMargin, right: -backgroundInnerMargin)
        boundEdges(of: mainVerticalStack, to: backgroundViewWithShadow!, with: insets)
        
        let innerHorizontalStack = getPresetUIStackView(axis: .horizontal, alignment: .center, distribution: .fillProportionally, spacing: 22)
        
        innerHorizontalStack.addArrangedSubview(titleLabel!)
        innerHorizontalStack.addArrangedSubview(timeLabel!)
        
        mainVerticalStack.addArrangedSubview(innerHorizontalStack)
        mainVerticalStack.addArrangedSubview(locationLabel!)
    }
}

