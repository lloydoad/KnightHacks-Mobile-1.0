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
    
    enum SubRoute: String {
        case schedule = "/schedule"
        case sponsor = "/sponsor"
    }
    
    public static func + (lhs: Route, rhs: SubRoute) -> String {
        return lhs.rawValue + rhs.rawValue
    }
}
