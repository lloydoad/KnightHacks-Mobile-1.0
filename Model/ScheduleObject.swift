//
//  ScheduleObject.swift
//  KnightHacks
//
//  Created by KnightHacks on 12/24/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import Foundation
import SwiftyJSON

class ScheduleObject {
    static let API_START_TIME_PARAMETER_KEY: String = "startTime"
    static let API_TITLE_PARAMETER_KEY: String = "title"
    static let API_EVENT_TYPE_PARAMETER_KEY: String = "eventType"
    static let API_LOCATION_PARAMETER_KEY: String = "location"
    static let API_END_TIME_PARAMETER_KEY: String = "endTime"
    
    var title: String
    var eventType: String
    var location: String
    var startTime: String
    var endTime: String
    var formattedTime: String = "invalid time"
    
    var startDateObject: Date?
    var endDateObject: Date?
    
    init(json: JSON) {
        title = json[ScheduleObject.API_TITLE_PARAMETER_KEY].stringValue
        eventType = json[ScheduleObject.API_EVENT_TYPE_PARAMETER_KEY].stringValue
        location = json[ScheduleObject.API_LOCATION_PARAMETER_KEY].stringValue
        startTime = json[ScheduleObject.API_START_TIME_PARAMETER_KEY].stringValue
        endTime = json[ScheduleObject.API_END_TIME_PARAMETER_KEY].stringValue
        
        parseDateObjects()
    }
    
    func parseDateObjects() {
        guard let parsedStartTime = StringDateFormatter.convertStringToZuluDate(dateString: startTime),
            let hourMinuteFormat = StringDateFormatter.getFormattedTime(from: parsedStartTime, with: .hourMinuteMeridiem) else {
            print("Start time parsing error")
            return
        }
        startDateObject = parsedStartTime
        formattedTime = hourMinuteFormat
        
        guard let parsedEndTime = StringDateFormatter.convertStringToZuluDate(dateString: endTime) else {
            print("End time parsing error")
            return
        }
        endDateObject = parsedEndTime
    }
}
