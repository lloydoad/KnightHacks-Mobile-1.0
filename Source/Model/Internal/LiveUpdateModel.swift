//
//  LiveUpdateModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/25/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

internal struct LiveUpdateModel: Comparable {
    
    var title: String
    var date: Date
    var time: String
    var imageURL: String?
    
    init(title: String, date: Date, time: String, imageURL: String? = nil) {
        self.title = title
        self.date = date
        self.time = time
        self.imageURL = imageURL
    }
    
    static func < (lhs: LiveUpdateModel, rhs: LiveUpdateModel) -> Bool {
        return lhs.date.timeIntervalSince1970 - rhs.date.timeIntervalSince1970 < 0
    }
}
