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
    var dateObject: Date?
    var formattedTime: String = "9:15pm - 29m ago"
    var imageUrl: String = ""
    var imageContainer: UIImageView = UIImageView()
    var defaultImage = UIImage(named: "knight hacks image")
    
    var unit: String?
    var timeSince: String?
    
    init(description: String, time: String, image: UIImage) {
        self.description = description
        self.time = time
        self.imageContainer.image = image
        getFormattedTime()
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
        let dateFormatter = StringDateFormatter()
        
        guard let retrievedDate = dateFormatter.convertStringToZuluDate(dateString: time),
            let hourMinuteFormatString = dateFormatter.getFormattedTime(from: retrievedDate, with: .hourMinuteMeridiem) else {
               return
        }
        
        dateObject = retrievedDate
        guard let timeSince = dateFormatter.getFormattedTime(from: retrievedDate, with: .timeSinceThen) else {
            return
        }
        
        formattedTime = hourMinuteFormatString + " - " + timeSince + " ago"
    }
}
