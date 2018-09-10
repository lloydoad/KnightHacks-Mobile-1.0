//
//  TableObjects.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 9/5/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
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
