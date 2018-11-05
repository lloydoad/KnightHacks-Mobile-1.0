//
//  StringDateFormatter.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 11/1/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import Foundation

class StringDateFormatter {
    var dateFormat: String = "HH:mm"
    var timeSince: String = ""
    var unit: String = "s"
    
    let ISO8601_FORMATTER: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
    let LOCAL_DATE_FORMATTER: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    func convertStringToZuluDate(dateString: String) -> Date? {
        let date = ISO8601_FORMATTER.date(from: dateString)
        return date
    }
    
    func convertZuluDateToString(dateObject: Date) -> String {
        return ISO8601_FORMATTER.string(from: dateObject)
    }
    
    func get(date: Date, after seconds: TimeInterval) -> Date {
        return date.addingTimeInterval(seconds)
    }
    
    func getFormattedTime(from date: Date, with format: DateStringFormat) -> String? {
        let zulu_string = convertZuluDateToString(dateObject: date)
        guard let zulu_date = convertStringToZuluDate(dateString: zulu_string) else {
            return nil
        }
        
        let local_zulu_string = convertZuluDateToString(dateObject: Date())
        guard let local_zulu_date = convertStringToZuluDate(dateString: local_zulu_string) else {
            return nil
        }
        
        switch format {
        case .timeSinceThen:
            let elapsedTime = local_zulu_date.timeIntervalSince(zulu_date)
            let seconds = elapsedTime
            let minutes = elapsedTime / 60
            let hours = elapsedTime / (60 * 60)
            let days = elapsedTime / (60 * 60 * 24)
            
            unit = "s"
            timeSince = String(format: "%0.0f", seconds)
            if seconds > 60 {
                unit = "m"
                timeSince = String(format: "%0.0f", minutes)
            }
            if minutes > 60 {
                unit = Int64(hours) == 1 ? "hr" : "hrs"
                timeSince = String(format: "%0.0f", hours)
            }
            if hours > 24 {
                unit = Int64(days) == 1 ? " day" : " days"
                timeSince = String(format: "%0.0f", days)
            }
            
            return timeSince + unit
        case .hourMinuteMeridiem:
            LOCAL_DATE_FORMATTER.dateFormat = "HH:mm"
            return LOCAL_DATE_FORMATTER.string(from: date)
        }
    }
}
