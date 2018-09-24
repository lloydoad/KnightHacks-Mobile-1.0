//
//  TableObjects.swift
//  KnightHacks
//
//  Created by KnightHacks on 9/5/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

class ScheduleObject {
    var name: String
    var dateTime: Any?
    var location: String
    var duration: Double
    var type: Filter
    
    init(name: String, dateTime: Any?, location: String, duration: Double, type: Filter) {
        self.name = name
        self.dateTime = dateTime
        self.location = location
        self.duration = duration
        self.type = type
    }
}

class LiveUpdateObject {
    var description: String
    var time: String
    var timeSince: Int
    var image: UIImage
    
    init(description: String, time: String, timeSince: Int, image: UIImage) {
        self.description = description
        self.time = time
        self.timeSince = timeSince
        self.image = image
    }
}
