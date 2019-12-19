//
//  ScheduleModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/21/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

internal struct CodableScheduleModel: Codable {
    var title: String
    var location: String
    var date: String
}

internal struct ScheduleModel: HeaderDataSource, FilterDataSource, Comparable, DictionaryCodable {
    
    enum Keys: String {
        case title
        case location
        case eventType
        case startTime
        case seconds
    }
    
    var filters: [FilterMenuModel]
    var title: String
    var location: String
    var time: String
    var header: String
    var date: Date
    
    init(title: String, location: String, time: String, header: String, date: Date, filters: [FilterMenuModel]) {
        self.title = title
        self.location = location
        self.time = time
        self.header = header
        self.date = date
        self.filters = filters
    }
    
    init(dataRecieved: NSDictionary) throws {
        
        guard
            let startTime = dataRecieved[Keys.startTime.rawValue] as? NSDictionary,
            let startTimeSeconds = startTime[Keys.seconds.rawValue] as? Int64,
            let title = dataRecieved[Keys.title.rawValue] as? String,
            let location = dataRecieved[Keys.location.rawValue] as? String,
            let eventType = dataRecieved[Keys.eventType.rawValue] as? String
        else {
            throw RuntimeException.dictionaryDecoding("Failed to parse schedule")
        }
        
        self.date = Date(timeIntervalSince1970: TimeInterval(startTimeSeconds))
        self.title = title
        self.location = location
        self.header = DateEngine(format: .dayMonth).getString(of: self.date, as: .dayMonth)
        self.time = DateEngine(format: .dayMonth).getString(of: self.date, as: .hourColonMinuteMeridian)
        self.filters = []
        
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate,
            let viewFilters = appdelegate.applicationFilters[ScheduleTableViewControllerModel.filterType] {
            self.filters = viewFilters.filter { (model) -> Bool in
                model.name == eventType
            }
        }
    }
    
    static func < (lhs: ScheduleModel, rhs: ScheduleModel) -> Bool {
        return lhs.date.timeIntervalSince1970 - rhs.date.timeIntervalSince1970 < 0
    }
}
