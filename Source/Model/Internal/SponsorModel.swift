//
//  SponsorModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/28/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

internal struct CodableSponsorModel: Codable {
    var name: String
    var location: String
    var imageURL: String
    var description: String
    var filters: [String]
}

internal struct SponsorModel: FilterDataSource {
    
    var name: String
    var location: String
    var imageURL: String?
    var description: String
    var filters: [FilterNames]
    
    init(name: String, location: String, imageURL: String?, description: String, filters: [FilterNames]) {
        self.name = name
        self.location = location
        self.imageURL = imageURL
        self.description = description
        self.filters = filters
    }
}
