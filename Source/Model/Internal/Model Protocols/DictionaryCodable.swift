//
//  DictionaryCodable.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 12/19/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

/**
 Codable protocol used for parsing firebase response objects
 */
public protocol DictionaryCodable {
    init(dataRecieved: NSDictionary) throws
}
