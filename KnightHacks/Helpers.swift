//
//  Helpers.swift
//  KnightHacks
//
//  Created by KnightHacks on 8/26/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

// convenient inits for getting colors
extension UIColor {
    // minimize init for uicolor
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    // make init for hex colors
    convenience init(hex: Int, alpha: CGFloat) {
        let red: Int = (hex >> 16) & 0xFF
        let green: Int = (hex >> 8) & 0xFF
        let blue: Int = hex & 0xFF
        self.init(red: red, green: green, blue: blue, a: alpha)
    }
    
    // get rgba values of existing uicolors
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
}

// create a stackview with defined properties
func getPresetUIStackView(axis: UILayoutConstraintAxis, alignment: UIStackViewAlignment, distribution: UIStackViewDistribution, spacing: CGFloat) -> UIStackView {
    let stack = UIStackView()
    stack.axis = axis
    stack.alignment = alignment
    stack.distribution = distribution
    stack.spacing = spacing
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
}

func boundEdges(of child: UIView, to parent: UIView, with borders: UIEdgeInsets) {
    child.translatesAutoresizingMaskIntoConstraints = false
    parent.addSubview(child)
    child.topAnchor.constraint(equalTo: parent.topAnchor, constant: borders.top).isActive = true
    child.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: borders.bottom).isActive = true
    child.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: borders.left).isActive = true
    child.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: borders.right).isActive = true
}

func createFormattedLabel(type: FormattedLabelType, defaultText: String, alignment: NSTextAlignment) -> UILabel {
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 110, height: 30))
    label.text = defaultText
    label.textAlignment = alignment
    
    if type == .title {
        label.textColor = BACKGROUND_COLOR
    } else if type == .paragraph {
        label.numberOfLines = 0
    }
    
    switch type {
    case .majorParagraph:
        label.font = MAJOR_PARAGRAPH_FONT
        break
    case .minorParagraph:
        label.font = MINOR_PARAGRAPH_FONT
        break
    case .paragraph:
        label.font = PARAGRAPH_FONT
        break
    default:
        label.font = TITLE_FONT
        break
    }
    
    return label
}
