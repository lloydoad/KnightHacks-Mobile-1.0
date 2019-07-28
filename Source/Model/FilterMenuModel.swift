//
//  FilterMenu.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 6/25/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

public struct FilterMenuModel {
    
    var name: String
    var imageName: String
    var type: FilterNames?
    
    /**
     Initializes content of Filter Button
     - Button name is formatted as-is for labels
     - Button images are constructed from the first image asset named "<name> filter icon"
     */
    init(name: String) {
        self.name = name
        self.imageName = "\(name.lowercased()) filter icon"
    }
    
    internal init(type: FilterNames) {
        self.init(name: type.rawValue)
        self.type = type
    }
}
