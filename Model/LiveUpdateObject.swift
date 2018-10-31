//
//  LiveUpdateObject.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 10/31/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit
import SwiftyJSON

class LiveUpdateObject {
    var description: String
    var time: String
    var formattedTime: String = "9:15pm - 29m ago"
    var imageUrl: String = ""
    var imageContainer: UIImageView = UIImageView()
    var defaultImage = UIImage(named: "knight hacks image")
    
    init(description: String, time: String, image: UIImage) {
        self.description = description
        self.time = time
        self.imageContainer.image = image
    }
    
    init(json: JSON) {
        description = json["message"].stringValue
        time = json["timeSent"].stringValue
        imageUrl = json["picture"].stringValue
        getFormattedTime()
        parseImage()
    }
    
    func parseImage() {
        RequestSingleton.getImage(at: imageUrl) { (response) in
            DispatchQueue.main.async {
                if(response != nil) {
                    self.imageContainer.image = response ?? self.defaultImage!
                }
            }
        }
    }
    
    func getFormattedTime() {
        let iso8601: ISO8601DateFormatter = {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            return formatter
        }()
        guard let retrievedDateObject = iso8601.date(from: time) else {
            print("Respond date parsing failed")
            return
        }
        let localToZuluTime = iso8601.string(from: Date())
        guard let localToZuluDateObject = iso8601.date(from: localToZuluTime) else {
            print("Could not convert local time to Zulu")
            return
        }
        
        let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            return formatter
        }()
        let hourMinuteFormatString = formatter.string(from: retrievedDateObject)
        
        var unit: String
        var timeSince: String
        let elapsedTime = localToZuluDateObject.timeIntervalSince(retrievedDateObject)
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
        
        formattedTime = hourMinuteFormatString + " - " + timeSince + unit + " ago"
    }
}
