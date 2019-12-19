//
//  LiveUpdateModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/25/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

internal struct CodableLiveUpdateModel: Codable {
    var description: String
    var date: String
    var imageURL: String
}

internal struct LiveUpdateModel: Comparable, DictionaryCodable {
    
    enum Keys: String {
        case picture
        case message
        case timeSent
        case seconds
    }
    
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
    
    init(dataRecieved: NSDictionary) throws {
        
        guard
            let startTime = dataRecieved[Keys.timeSent.rawValue] as? NSDictionary,
            let startTimeSeconds = startTime[Keys.seconds.rawValue] as? Int64,
            let message = dataRecieved[Keys.message.rawValue] as? String,
            let picture = dataRecieved[Keys.picture.rawValue] as? String
        else {
            throw RuntimeException.dictionaryDecoding("Failed to parse live update")
        }
        
        self.date = Date(timeIntervalSince1970: TimeInterval(startTimeSeconds))
        self.title = message
        self.imageURL = picture == "live-updates/kh-blue.png" ? nil : picture
        self.time = DateEngine(format: .standardISO1806).getString(of: self.date, as: .hourColonMinuteMeridian)
    }
    
    static func < (lhs: LiveUpdateModel, rhs: LiveUpdateModel) -> Bool {
        return lhs.date.timeIntervalSince1970 - rhs.date.timeIntervalSince1970 < 0
    }
}
