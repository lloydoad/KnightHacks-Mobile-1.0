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
