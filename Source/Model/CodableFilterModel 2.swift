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
}
