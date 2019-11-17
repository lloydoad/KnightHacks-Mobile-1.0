//
//  WorkshopModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/25/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

internal struct CodableWorkshopModel: Codable {
    var name: String
    var date: String
    var location: String
    var imageURL: String
    var description: String
}

internal struct WorkshopDictionaryModel: DictionaryCodable {
    
    enum Keys: String {
        case description
        case endTime
        case name
        case picture
        case prerequisites
        case skillLevel
        case workshopType
        case startTime
        case seconds
    }
    
    var description: String
    var date: Int64
    var name: String
    var imageURL: String
    var filters: [String]
    
    init(dataRecieved: NSDictionary) throws {
        guard
            let start = dataRecieved[Keys.startTime.rawValue] as? NSDictionary,
            let date = start[Keys.seconds.rawValue] as? Int64
        else {
             throw ReadingError.parseFail("Failed to parse workshops")
        }
        self.date = date
        
        self.description = dataRecieved[Keys.description.rawValue] as? String ?? ""
        self.name = dataRecieved[Keys.name.rawValue] as? String ?? ""
        self.imageURL = dataRecieved[Keys.picture.rawValue] as? String ?? ""
        
        if
            let skillLevel = dataRecieved[Keys.skillLevel.rawValue] as? String,
            let workshopType = dataRecieved[Keys.workshopType.rawValue] as? String {
            self.filters = [skillLevel, workshopType]
        } else {
            self.filters = []
        }
    }
}

internal struct WorkshopModel: HeaderDataSource, FilterDataSource, Comparable {
    
    var date: Date
    var time: String
    var title: String
    var header: String
    var imageURL: String?
    var description: String
    var filters: [FilterMenuModel]
    
    init(date: Date, time: String, title: String, header: String, imageURL: String? = nil, description: String, filters: [FilterMenuModel]) {
        self.date = date
        self.time = time
        self.title = title
        self.header = header
        self.imageURL = imageURL
        self.description = description
        self.filters = filters
    }
    
    static func < (lhs: WorkshopModel, rhs: WorkshopModel) -> Bool {
        return lhs.date.timeIntervalSince1970 - rhs.date.timeIntervalSince1970 < 0
    }
}
