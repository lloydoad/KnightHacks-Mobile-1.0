//
//  Misc.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 6/25/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//
//  Linter overrides
//  swiftlint:disable identifier_name

import UIKit

public var HEADER_IN_SECTION_HEIGHT: Float = 60

internal func addSpecifiedShadow(_ view: UIView?) {
    view?.layer.shadowColor = UIColor.gray.cgColor
    view?.layer.shadowOffset = CGSize(width: 0.2, height: 0.3)
    view?.layer.shadowRadius = 0.8
    view?.layer.cornerRadius = 14
    view?.layer.shadowOpacity = 1
}

internal func boundEdges(of child: UIView, to parent: UIView, with borders: UIEdgeInsets) {
    child.translatesAutoresizingMaskIntoConstraints = false
    parent.addSubview(child)
    child.topAnchor.constraint(equalTo: parent.topAnchor, constant: borders.top).isActive = true
    child.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: borders.bottom).isActive = true
    child.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: borders.left).isActive = true
    child.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: borders.right).isActive = true
}

internal func createTagInView(defaultText: String = "default tag") -> UIView {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 81, height: 22))
    view.layer.cornerRadius = 7.2
    view.clipsToBounds = true
    let gradient = CAGradientLayer()
    gradient.startPoint = CGPoint.zero
    gradient.endPoint = CGPoint(x: 1, y: 1)
    gradient.colors = [LIGHT_BLUE_SHADE_COLOR.cgColor, DARK_BLUE_SHADE_COLOR.cgColor]
    
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 110, height: 30))
    label.text = defaultText
    label.textAlignment = .center
    label.font = MINOR_PARAGRAPH_FONT
    label.textColor = .white
    
    view.translatesAutoresizingMaskIntoConstraints = false
    view.heightAnchor.constraint(equalToConstant: 22).isActive = true
    view.widthAnchor.constraint(equalToConstant: 81).isActive = true
    gradient.frame = view.frame
    view.layer.insertSublayer(gradient, at: 0)
    
    view.addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
    return view
}
