//
//  ScheduleModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/21/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

internal struct CodableScheduleModel: Codable {
    var title: String
    var location: String
    var date: String
}

internal struct ScheduleModel: HeaderDataSource, FilterDataSource, Comparable {
    
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
    
    static func < (lhs: ScheduleModel, rhs: ScheduleModel) -> Bool {
        return lhs.date.timeIntervalSince1970 - rhs.date.timeIntervalSince1970 < 0
    }
}
