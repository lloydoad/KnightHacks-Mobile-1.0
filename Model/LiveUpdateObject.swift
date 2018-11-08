//
//  LiveUpdateObject.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 10/31/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol LiveUpdateObjectImageDelegate {
    func reloadImageContainers()
}

class LiveUpdateObject {
    static let API_DATE_PARAMETER_KEY: String = "date"
    static let API_DESCRIPTION_PARAMETER_KEY: String = "message"
    static let API_TIME_PARAMETER_KEY: String = "timeSent"
    static let API_IMAGE_URL_PARAMETER_KEY: String = "picture"
    
    var description: String
    var time: String
    
    var formattedTime: String = "00:00xx - 0m ago"
    var imageUrl: String = ""
    var imageContainer: UIImageView = UIImageView()
    var defaultImage = UIImage(named: "knight hacks image")
    
    var dateObject: Date?
    var unit: String?
    var timeSince: String?
    var delegate: LiveUpdateObjectImageDelegate?
    
    init(description: String, time: String, image: UIImage) {
        self.description = description
        self.time = time
        self.imageContainer.image = image
        getFormattedTime()
    }
    
    init(json: JSON) {
        description = json[LiveUpdateObject.API_DESCRIPTION_PARAMETER_KEY].stringValue
        time = json[LiveUpdateObject.API_TIME_PARAMETER_KEY].stringValue
        imageUrl = json[LiveUpdateObject.API_IMAGE_URL_PARAMETER_KEY].stringValue
        getFormattedTime()
        parseImage(at: imageUrl, into: imageContainer) {
            if self.delegate != nil {
                self.delegate!.reloadImageContainers()
            }
        }
    }
    
    func getFormattedTime() {        
        guard let retrievedDate = StringDateFormatter.convertStringToZuluDate(dateString: time),
            let hourMinuteFormatString = StringDateFormatter.getFormattedTime(from: retrievedDate, with: .hourMinuteMeridiem),
            let timeSince = StringDateFormatter.getFormattedTime(from: retrievedDate, with: .timeSinceThen) else {
               return
        }
        dateObject = retrievedDate
        
        formattedTime = hourMinuteFormatString + " - " + timeSince + " ago"
    }
}
