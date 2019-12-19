//
//  SponsorModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/28/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

internal struct CodableSponsorModel: Codable {
    var name: String
    var location: String
    var imageURL: String
    var description: String
}

internal struct SponsorModel: FilterDataSource {
    
    enum Keys: String {
        case description
        case location
        case name
        case offerings
        case picture
    }
    
    var name: String
    var location: String
    var imageURL: String?
    var description: String
    var filters: [FilterMenuModel]
    
    init(name: String, location: String, imageURL: String?, description: String, filters: [FilterMenuModel]) {
        self.name = name
        self.location = location
        self.imageURL = imageURL
        self.description = description
        self.filters = filters
    }
}
