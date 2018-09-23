//
//  HiddenDetailDynamicTableViewCell.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 9/18/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

extension DynamicTableViewCell {
    func setuphiddenDetailedCellView() {
        createBackgroundView()
        createHiddenDetailUIElements()
        setConstraintForHiddenDetailUIElements()
    }
    
    func createHiddenDetailUIElements() {
        showMoreButton = UIButton(type: .system)
        showMoreButton?.contentMode = .scaleAspectFit
        showMoreButton?.backgroundColor = .clear
        
        titleLabel = createFormattedLabel(type: .majorParagraph, defaultText: "What is knightHacks?", alignment: .left)
        titleLabel?.font = MAJOR_REGULAR_FONT
        titleLabel?.numberOfLines = 0
        
        itemDescriptionLabel = createFormattedLabel(type: .paragraph, defaultText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin", alignment: .left)
        itemDescriptionLabel?.numberOfLines = 0
    }
    
    func setConstraintForHiddenDetailUIElements() {
        let mainVerticalStack = getPresetUIStackView(axis: .vertical, alignment: .fill, distribution: .fill, spacing: 0)
        
        backgroundViewWithShadow?.addSubview(showMoreButton!)
        showMoreButton?.translatesAutoresizingMaskIntoConstraints = false
        showMoreButton?.heightAnchor.constraint(equalToConstant: hiddenDetailMaximizeButtonLength).isActive = true
        showMoreButton?.widthAnchor.constraint(equalToConstant: hiddenDetailMaximizeButtonLength).isActive = true
        showMoreButton?.topAnchor.constraint(equalTo: backgroundViewWithShadow!.topAnchor, constant: backgroundInnerMargin).isActive = true
        showMoreButton?.leadingAnchor.constraint(equalTo: backgroundViewWithShadow!.leadingAnchor, constant: backgroundInnerMargin).isActive = true
        
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.heightAnchor.constraint(greaterThanOrEqualToConstant: REDUCED_ROW_HEIGHT - 70).isActive = true
        
        backgroundViewWithShadow?.addSubview(mainVerticalStack)
        mainVerticalStack.translatesAutoresizingMaskIntoConstraints = false
        mainVerticalStack.topAnchor.constraint(equalTo: (backgroundViewWithShadow?.topAnchor)!, constant: backgroundInnerMargin - 7).isActive = true
        mainVerticalStack.bottomAnchor.constraint(equalTo: (backgroundViewWithShadow?.bottomAnchor)!, constant: -backgroundInnerMargin).isActive = true
        mainVerticalStack.leadingAnchor.constraint(equalTo: (showMoreButton?.trailingAnchor)!, constant: backgroundInnerMargin).isActive = true
        mainVerticalStack.trailingAnchor.constraint(equalTo: (backgroundViewWithShadow?.trailingAnchor)!, constant: -backgroundInnerMargin).isActive = true
        mainVerticalStack.heightAnchor.constraint(greaterThanOrEqualToConstant: REDUCED_ROW_HEIGHT - 50).isActive = true
        
        mainVerticalStack.addArrangedSubview(titleLabel!)
        mainVerticalStack.addArrangedSubview(UIView())
        
        if isShowingDetails && cellType == .hiddenDetailedCell {
            mainVerticalStack.addArrangedSubview(itemDescriptionLabel!)
            showMoreButton?.setBackgroundImage(UIImage(named: "show less button"), for: .normal)
        } else if cellType == .hiddenDetailedCell && !isShowingDetails {
            showMoreButton?.setBackgroundImage(UIImage(named: "show more button"), for: .normal)
        }
    }
}
