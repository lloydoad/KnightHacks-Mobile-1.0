//
//  URLs.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 8/3/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

/**
 Routes are currently referencing dummy data and need to be replaced
 */
internal enum Route: String {
    
    case server = "https://5d3a68a3fa091c0014470961.mockapi.io/connect"
    case altserver = "https://5d867766cd71160014aae6d4.mockapi.io/api/v1"
    
    enum SubRoute: String {
        case schedule = "/schedule"
        case faqs = "/faqs"
        case sponsor = "/sponsor"
        case workshop = "/workshop"
        case liveupdate = "/liveupdates"
    }
    
    public static func + (lhs: Route, rhs: SubRoute) -> String {
        return lhs.rawValue + rhs.rawValue
    }
}
