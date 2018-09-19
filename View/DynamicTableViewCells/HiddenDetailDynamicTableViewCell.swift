//
//  HiddenDetailDynamicTableViewCell.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 9/18/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

extension DynamicTableViewCell {
    func setuphiddenDetailedCellView() {
        createBackgroundView()
        
        showMoreButton = UIButton(type: .system)
        showMoreButton?.contentMode = .scaleAspectFit
        showMoreButton?.setBackgroundImage(UIImage(named: "show more button"), for: .normal)
        showMoreButton?.backgroundColor = .clear
        showMoreButton?.translatesAutoresizingMaskIntoConstraints = false
        showMoreButton?.heightAnchor.constraint(equalToConstant: 27).isActive = true
        showMoreButton?.widthAnchor.constraint(equalToConstant: 27).isActive = true
        
        backgroundViewWithShadow?.addSubview(showMoreButton!)
        showMoreButton?.topAnchor.constraint(equalTo: (backgroundViewWithShadow?.topAnchor)!, constant: backgroundInnerMargin).isActive = true
        showMoreButton?.leadingAnchor.constraint(equalTo: backgroundViewWithShadow!.leadingAnchor, constant: backgroundInnerMargin).isActive = true
        
        let mainVerticalStack = UIStackView()
        mainVerticalStack.axis = .vertical
        mainVerticalStack.alignment = .fill
        mainVerticalStack.distribution = .fill
        mainVerticalStack.spacing = 0
        mainVerticalStack.translatesAutoresizingMaskIntoConstraints = false
        backgroundViewWithShadow?.addSubview(mainVerticalStack)
        mainVerticalStack.topAnchor.constraint(equalTo: (backgroundViewWithShadow?.topAnchor)!, constant: backgroundInnerMargin - 7).isActive = true
        mainVerticalStack.bottomAnchor.constraint(equalTo: (backgroundViewWithShadow?.bottomAnchor)!, constant: -backgroundInnerMargin).isActive = true
        mainVerticalStack.leadingAnchor.constraint(equalTo: (showMoreButton?.trailingAnchor)!, constant: backgroundInnerMargin).isActive = true
        mainVerticalStack.trailingAnchor.constraint(equalTo: (backgroundViewWithShadow?.trailingAnchor)!, constant: -backgroundInnerMargin).isActive = true
        mainVerticalStack.heightAnchor.constraint(greaterThanOrEqualToConstant: REDUCED_ROW_HEIGHT - 50).isActive = true
        
        titleLabel = createFormattedLabel(type: .majorParagraph, defaultText: "What is knightHacks?", alignment: .left)
        titleLabel?.font = MAJOR_REGULAR_FONT
        titleLabel?.numberOfLines = 0
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.heightAnchor.constraint(greaterThanOrEqualToConstant: REDUCED_ROW_HEIGHT - 70).isActive = true
        mainVerticalStack.addArrangedSubview(titleLabel!)
        mainVerticalStack.addArrangedSubview(UIView())
        
        itemDescriptionLabel = createFormattedLabel(type: .paragraph, defaultText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin", alignment: .left)
        itemDescriptionLabel?.numberOfLines = 0
        if isShowingDetails && cellType == .hiddenDetailedCell {
            mainVerticalStack.addArrangedSubview(itemDescriptionLabel!)
        }
    }
}
