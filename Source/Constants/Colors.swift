//
//  Colors.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 6/23/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//
//  Linter overrides
//  swiftlint:disable identifier_name

import UIKit

public extension UIColor {
    /**
     minimize init for uicolor
     */
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    /**
     make init for hex colors
     */
    convenience init(hex: Int, alpha: CGFloat) {
        let red: Int = (hex >> 16) & 0xFF
        let green: Int = (hex >> 8) & 0xFF
        let blue: Int = hex & 0xFF
        self.init(red: red, green: green, blue: blue, a: alpha)
    }
    
    /**
     get rgba values of existing uicolors
     */
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
}

let ORANGE_COLOR = UIColor(hex: 0xFF9500, alpha: 1)
let BLUE_COLOR = UIColor(hex: 0x057AFF, alpha: 1)
let GREEN_COLOR = UIColor(hex: 0x26AE60, alpha: 1)
let RED_COLOR = UIColor(hex: 0xFF3B31, alpha: 1)
let DARK_GREEN_COLOR = UIColor(hex: 0x229A55, alpha: 1)
let DARK_PURPLE_COLOR = UIColor(hex: 0x250951, alpha: 1)

var BACKGROUND_COLOR = UIColor(hex: 0x5755D6, alpha: 1)
var SCHEDULE_MENU_COLOR = UIColor(hex: 0xFF9500, alpha: 1)
var WORKSHOPS_MENU_COLOR = UIColor(hex: 0xFF3B31, alpha: 1)
var SPONSORS_MENU_COLOR = UIColor(hex: 0x5755D6, alpha: 1)
var LIVE_UPDATES_MENU_COLOR = UIColor(hex: 0x057AFF, alpha: 1)
var FAQS_MENU_COLOR = UIColor(hex: 0x229A55, alpha: 1)
var PROFILE_MENU_COLOR = UIColor(hex: 0x057AFF, alpha: 1)

let LIGHT_BLUE_SHADE_COLOR = UIColor(hex: 0x0CB2FF, alpha: 1)
let DARK_BLUE_SHADE_COLOR = UIColor(hex: 0x057AFF, alpha: 1)

public enum ColorSchemeName: String {
    case backgroundColor
    case scheduleMenuColor
    case workshopMenuColor
    case sponsorsMenuColor
    case liveUpdatesMenuColor
    case faqsMenuColor
    case profileMenuColor
}
