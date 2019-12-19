//
//  UserDefaultsHolder.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 12/19/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

struct UserDefaultsHolder {
    enum RequestKey: String {
        case isSubscribedToGeneralNotifications
        case isSubscribedToFoodNotifications
        case isSubscribedToEmergencyNotifications
    }
    
    static func getUserDefaultValueFor(_ key: RequestKey) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
    static func set(value: Bool, for key: RequestKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
}
