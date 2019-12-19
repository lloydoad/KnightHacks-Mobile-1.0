//
//  Date Engine.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/21/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

public enum DateFormat: String {
    case dayMonth = "EEEE MM/dd"
    case hourColonMinute = "HH:mm"
    case dashedYearMonthDay = "yyyy-MM-dd"
    case slashYearMonthDay = "yyyy/MM/dd"
    case hourColonMinuteMeridian = "h:mm a"
    case yearThroughSecond = "yyyy-MM-dd'T'HH:mm:ss"
    case standardISO1806 = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case slashYearMonthDay24HourMinute = "yyyy/MM/dd/HH/mm"
}

public struct DateEngine {
    
    private var formatter: DateFormatter = DateFormatter()
    
    public init(format: DateFormat = .dashedYearMonthDay) {
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone(identifier: "EST")
        setDateFormat(format)
    }
    
    public func setDateFormat(_ format: DateFormat) {
        formatter.dateFormat = format.rawValue
    }
    
    public func getDate(from string: String) -> Date? {
        return formatter.date(from: string)
    }
    
    public func getString(of date: Date, as format: DateFormat) -> String {
        let oldFormat = self.formatter.dateFormat
        self.formatter.dateFormat = format.rawValue
        let result = formatter.string(from: date)
        self.formatter.dateFormat = oldFormat
        return result
    }
}
