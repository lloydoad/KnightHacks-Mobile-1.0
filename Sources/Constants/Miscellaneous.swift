//
//  Misc.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 6/25/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

internal func addSpecifiedShadow(_ view: UIView?) {
    view?.layer.shadowColor = UIColor.gray.cgColor
    view?.layer.shadowOffset = CGSize(width: 0.2, height: 0.3)
    view?.layer.shadowRadius = 0.8
    view?.layer.cornerRadius = 14
    view?.layer.shadowOpacity = 1
}

public var HEADER_IN_SECTION_HEIGHT: Float = 60
