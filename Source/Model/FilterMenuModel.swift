//
//  FilterMenu.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 6/25/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

public struct FilterMenuModel: Hashable {
    
    var name: String
    var imageURL: String
    var isLocal: Bool

    /**
     Initializes content of Filter Button
     - Button name is formatted as-is for labels
     - Button images are constructed from the first image asset named "<name> filter icon"
     */
    init(name: String) {
        self.name = name
        self.imageURL = "\(name.lowercased()) filter icon"
        self.isLocal = true
    }
    
    init(codable: CodableFilterModel) {
        self.name = codable.name
        self.imageURL = codable.imageURL
        self.isLocal = false
    }
    
    init(name: String, externalImageURL: String) {
        self.name = name
        self.imageURL = externalImageURL
        self.isLocal = false
    }
    
    public func hash(hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(imageURL)
    }
}

internal struct FilterDictionaryModel: DictionaryCodable {
    
    enum Keys: String {
        case name
        case picture
        case type
    }
    
    var name: String
    var imageURL: String
    var associatedView: String
    
    init(dataRecieved: NSDictionary) throws {
        guard
            let name = dataRecieved[Keys.name.rawValue] as? String,
            let imageURL = dataRecieved[Keys.picture.rawValue] as? String,
            let associatedView = dataRecieved[Keys.type.rawValue] as? String
        else {
            throw RuntimeException.dictionaryDecoding("Failed to parse filter")
        }
        
        self.name = name
        self.imageURL = imageURL
        self.associatedView = associatedView
    }
}
