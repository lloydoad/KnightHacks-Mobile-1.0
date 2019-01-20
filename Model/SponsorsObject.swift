//
//  SponsorsObject.swift
//  KnightHacks
//
//  Created by KnightHacks on 1/19/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation
import SwiftyJSON

class SponsorsObject {
    static let API_NAME_PARAMETER_KEY: String = "name"
    static let API_LOCATION_PARAMETER_KEY: String = "location"
    static let API_PICTURE_PARAMETER_KEY: String = "picture"
    static let API_DESCRIPTION_KEY: String = "description"
    static let API_OFFERING_PARAMATER_KEY: String = "offerings"
    
    var name: String
    var location: String
    var imageUrl: String
    var description: String
    var offerings: [String] = []
    var filters: [Filter] = []
    
    init(json: JSON) {
        name = json[SponsorsObject.API_NAME_PARAMETER_KEY].stringValue
        imageUrl = json[SponsorsObject.API_PICTURE_PARAMETER_KEY].stringValue
        description = json[SponsorsObject.API_DESCRIPTION_KEY].stringValue
        location = json[SponsorsObject.API_LOCATION_PARAMETER_KEY].stringValue
        offerings = json[SponsorsObject.API_OFFERING_PARAMATER_KEY].arrayValue.map { $0.stringValue }
        
        parseFilterData()
    }
    
    init(name: String, description: String, offerings: [String], location: String, imgUrl: String?) {
        self.name = name
        self.imageUrl = imgUrl ?? ""
        self.description = description
        self.location = location
        self.offerings = offerings
        
        parseFilterData()
    }
    
    func parseFilterData() {
        let internshipFilter = ["internships", "internship"]
        let fulltimeFilter = ["full time", "full-time", "fulltime"]
        
        if String(location.suffix(2)) == "FL" {
            filters.append(Filter.local)
        }

        offerings.forEach {
            if internshipFilter.contains($0) {
                filters.append(Filter.internships)
            } else if fulltimeFilter.contains($0) {
                filters.append(Filter.full_time)
            }
        }
    }
}
