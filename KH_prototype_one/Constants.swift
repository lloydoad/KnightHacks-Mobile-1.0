//
//  Constants.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 8/28/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.

import UIKit

// Colors
let ORANGE_COLOR = UIColor(hex: 0xFF9500, alpha: 1)
let BLUE_COLOR = UIColor(hex: 0x057AFF, alpha: 1)
let GREEN_COLOR = UIColor(hex: 0x26AE60, alpha: 1)
let RED_COLOR = UIColor(hex: 0xFF3B31, alpha: 1)
let BACKGROUND_COLOR = UIColor(hex: 0x5755D6, alpha: 1)

// assuming navbar has a default height of 44, 64 including status bar
let NAVBAR_HEIGHT: CGFloat = 64
// reduced total height of filter menu because menu took up a lot of space on smaller devices
let COMBINED_FILTER_HEIGHT: CGFloat = 200
// controls the height of the live count in live update view
let LIVE_UPDATE_VIEW_HEIGHT: CGFloat = 146

// faq row height controls
let REDUCED_ROW_HEIGHT: CGFloat = 110

// Filter enumerations
// Determines type of filter returned
enum Filter: String {
    case workshops = "workshops"
    case all = "all"
    case talks = "talks"
    case internships = "internships"
    case full_time = "full-time"
    case development = "development"
    case design = "design"
    case NOT_SET = "nil"
}

// Cell type enumerations
enum FormattedTableViewCellType {
    case defaultCell
    case leftImageCell
    case hiddenDetailedCell
    case detailedCell
}

// Label formatting enumerations
enum FormattedLabelType {
    case title
    case majorParagraph
    case minorParagraph
    case paragraph
}

// Fonts in app
let PARAGRAPH_FONT = UIFont.systemFont(ofSize: 14, weight: .regular)
let MINOR_PARAGRAPH_FONT = UIFont.systemFont(ofSize: 11.5, weight: .light)
let TITLE_FONT = UIFont.systemFont(ofSize: 20, weight: .bold)
let MAJOR_PARAGRAPH_FONT = UIFont.systemFont(ofSize: 24, weight: .regular)
let MAJOR_REGULAR_FONT = UIFont.systemFont(ofSize: 20, weight: .regular)
