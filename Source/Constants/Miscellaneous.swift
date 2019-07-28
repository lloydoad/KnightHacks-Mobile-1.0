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
