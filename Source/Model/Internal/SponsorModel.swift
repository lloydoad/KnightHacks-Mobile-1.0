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

internal struct SponsorModel: FilterDataSource, DictionaryCodable {
    
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
    
    init(dataRecieved: NSDictionary) throws {
        
        guard
            let description = dataRecieved[Keys.description.rawValue] as? String,
            let name = dataRecieved[Keys.name.rawValue] as? String,
            let picture = dataRecieved[Keys.picture.rawValue] as? String,
            let location = dataRecieved[Keys.location.rawValue] as? String
        else {
            throw RuntimeException.dictionaryDecoding("Failed to parse sponsor")
        }
        
        self.description = description
        self.name = name
        self.imageURL = picture
        self.location = location
        self.filters = []
        
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate,
            let viewFilters = appdelegate.applicationFilters[WorkshopTableViewControllerModel.filterType] {
            self.filters = viewFilters.filter { (model) -> Bool in
                model.name == "Full Time" || model.name == "Internships"
            }
        }
    }
}
