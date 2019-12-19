//
//  WorkshopModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/25/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

internal struct CodableWorkshopModel: Codable {
    var name: String
    var date: String
    var location: String
    var imageURL: String
    var description: String
}

internal struct WorkshopModel: HeaderDataSource, FilterDataSource, DictionaryCodable, Comparable {
    
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
    
    init(dataRecieved: NSDictionary) throws {
        
        guard
            let startTime = dataRecieved[Keys.startTime.rawValue] as? NSDictionary,
            let startTimeSeconds = startTime[Keys.seconds.rawValue] as? Int64,
            let description = dataRecieved[Keys.description.rawValue] as? String,
            let name = dataRecieved[Keys.name.rawValue] as? String,
            let imageURL = dataRecieved[Keys.picture.rawValue] as? String,
            let skillLevel = dataRecieved[Keys.skillLevel.rawValue] as? String,
            let workshopType = dataRecieved[Keys.workshopType.rawValue] as? String
        else {
            throw RuntimeException.dictionaryDecoding("Failed to parse workshop")
        }
        
        self.date = Date(timeIntervalSince1970: TimeInterval(startTimeSeconds))
        self.description = description
        self.title = name
        self.imageURL = imageURL
        self.header = DateEngine(format: .dayMonth).getString(of: self.date, as: .dayMonth)
        self.time = DateEngine(format: .dayMonth).getString(of: self.date, as: .hourColonMinuteMeridian)
        self.filters = []
        
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate,
            let viewFilters = appdelegate.applicationFilters[WorkshopTableViewControllerModel.filterType] {
            self.filters = viewFilters.filter { (model) -> Bool in
                model.name == skillLevel || model.name == workshopType
            }
        }
    }
    
    static func < (lhs: WorkshopModel, rhs: WorkshopModel) -> Bool {
        return lhs.date.timeIntervalSince1970 - rhs.date.timeIntervalSince1970 < 0
    }
}
