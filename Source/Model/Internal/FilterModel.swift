//
//  FilterModel.swift
//  KnightHacks
//
//  Created by Patrick Stoebenau on 9/29/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

internal struct CodableFilterModel: Codable {
    var id: String
    var workshopId: String
    var name: String
    var imageURL: String
    
    init(id: String, workshopId: String, name: String, imageURL: String) {
        self.id = id;
        self.workshopId = workshopId;
        self.name = name;
        self.imageURL = imageURL;
    }
}
