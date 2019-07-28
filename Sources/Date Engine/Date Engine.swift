//
//  Date Engine.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/21/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

public enum DateFormat: String {
    case hourColonMinute = "HH:mm"
    case dashedYearMonthDay = "yyyy-MM-dd"
    case slashYearMonthDay = "yyyy/MM/dd"
    case yearThroughSecond = "yyyy-MM-dd'T'HH:mm:ss"
    case slashYearMonthDay24HourMinute = "yyyy/MM/dd/HH/mm"
}

public struct DateEngine {
    var formatter: DateFormatter = DateFormatter()
    
    init(format: DateFormat = .dashedYearMonthDay) {
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        setDateFormat(format)
    }
    
    func setDateFormat(_ format: DateFormat) {
        formatter.dateFormat = format.rawValue
    }
    
    func getDateFrom(_ string: String) -> Date? {
        return formatter.date(from: string)
    }
}
