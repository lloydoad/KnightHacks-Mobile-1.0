//
//  LatoFonts.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 6/27/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

enum LatoFont: String {
    case regular = "Lato-Regular"
    case ultralight = "Lato-Hairline"
    case bold = "Lato-Bold"
    case black = "Lato-Black"
    case light = "Lato-Light"
}

// fonts in app
let PARAGRAPH_FONT = UIFont(name: LatoFont.regular.rawValue, size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .regular)

let MINOR_PARAGRAPH_FONT = UIFont(name: LatoFont.light.rawValue, size: 11.5) ?? UIFont.systemFont(ofSize: 11.5, weight: .light)

let TITLE_FONT = UIFont(name: LatoFont.bold.rawValue, size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .bold)

let LIGHT_TITLE_FONT = UIFont(name: LatoFont.light.rawValue, size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .light)

let MAJOR_PARAGRAPH_FONT = UIFont(name: LatoFont.regular.rawValue, size: 24) ?? UIFont.systemFont(ofSize: 24, weight: .regular)

let BOLD_TITLE_FONT = UIFont(name: LatoFont.bold.rawValue, size: 24) ?? UIFont.systemFont(ofSize: 24, weight: .bold)

let MAJOR_REGULAR_FONT = UIFont(name: LatoFont.regular.rawValue, size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .regular)

let CELL_HEADER_FONT = UIFont(name: LatoFont.bold.rawValue, size: 36) ?? UIFont.systemFont(ofSize: 36, weight: UIFont.Weight.medium)

let HEADER_FONT = UIFont(name: LatoFont.regular.rawValue, size: 30) ?? UIFont.systemFont(ofSize: 30)

let BIG_HEADER_FONT = UIFont(name: LatoFont.bold.rawValue, size: 35) ?? UIFont.systemFont(ofSize: 35, weight: .bold)

let BIG_ULTRA_LIGHT_HEADER_FONT = UIFont(name: LatoFont.ultralight.rawValue, size: 55) ?? UIFont.systemFont(ofSize: 55, weight: .ultraLight)
