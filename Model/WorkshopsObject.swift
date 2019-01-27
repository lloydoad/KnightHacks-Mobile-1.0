
//
//  WorkshopsObject.swift
//  KnightHacks
//
//  Created by KnightHacks on 12/23/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import Foundation
import SwiftyJSON

struct WorkshopsGroup {
    var day: String
    var objects: [WorkshopsObject]
}

class WorkshopsObject {
    static let API_NAME_PARAMETER_KEY: String = "name"
    static let API_PICTURE_PARAMETER_KEY: String = "picture"
    static let API_START_TIME_PARAMETER_KEY: String = "startTime"
    static let API_END_TIME_PARAMETER_KEY: String = "endTime"
    static let API_DESCRIPTION_KEY: String = "description"
    static let API_TAG_PARAMATER_KEYS: [String] = ["skillLevel", "workshopType"]
    
    var name: String
    var imageUrl: String
    var startTimeString: String
    var endTimeString: String
    var description: String
    var tags: [String] = []

    var formattedTime: String = "invalid time"
    var formattedHeader: String = "invalid header"
    var imageContainer: UIImageView = UIImageView()
    
    var startDateObject: Date?
    var endDateObject: Date?
    
    init(json: JSON) {
        name = json[WorkshopsObject.API_NAME_PARAMETER_KEY].stringValue
        imageUrl = json[WorkshopsObject.API_PICTURE_PARAMETER_KEY].stringValue
        startTimeString = json[WorkshopsObject.API_START_TIME_PARAMETER_KEY].stringValue
        endTimeString = json[WorkshopsObject.API_END_TIME_PARAMETER_KEY].stringValue
        description = json[WorkshopsObject.API_DESCRIPTION_KEY].stringValue
        
        WorkshopsObject.API_TAG_PARAMATER_KEYS.forEach {
            let retrievedTag = json[$0].stringValue.lowercased()
            if !tags.contains(retrievedTag) {
                tags.append(retrievedTag)
            }
        }
        
        parseDateObjects()
        parseHeaderInfo()
    }
    
    init(name: String, starttime: String, endtime: String, description: String, tags: [String], imgUrl: String?) {
        self.name = name
        self.imageUrl = imgUrl ?? "none"
        self.startTimeString = starttime
        self.endTimeString = endtime
        self.description = description
        self.tags = tags
        
        parseDateObjects()
        parseHeaderInfo()
        
        if let url = imgUrl {
            parseImage(at: url, into: self.imageContainer, completion: nil)
        } else {
            self.imageContainer.image = UIImage(named: "knight hacks image")
        }
    }
    
    func parseHeaderInfo() {
        var formattedHeaderTitle: String = ""
        
        if let startDateObject = self.startDateObject {
            formattedHeaderTitle += StringDateFormatter.getFormattedTime(from: startDateObject, with: .dayOfWeek) ?? ""
            formattedHeaderTitle += ", \(StringDateFormatter.getFormattedTime(from: startDateObject, with: .monthAndDay) ?? "")"
            
            self.formattedHeader = formattedHeaderTitle
        }
    }
    
    func parseDateObjects() {
        guard let parsedStartTime = StringDateFormatter.convertStringToZuluDate(dateString: startTimeString),
            let hourMinuteFormat = StringDateFormatter.getFormattedTime(from: parsedStartTime, with: .hourMinuteMeridiem) else {
                print("Start time parsing error")
                return
        }
        startDateObject = parsedStartTime
        formattedTime = hourMinuteFormat
        
        guard let parsedEndTime = StringDateFormatter.convertStringToZuluDate(dateString: endTimeString) else {
            print("End time parsing error")
            return
        }
        endDateObject = parsedEndTime
    }
}
