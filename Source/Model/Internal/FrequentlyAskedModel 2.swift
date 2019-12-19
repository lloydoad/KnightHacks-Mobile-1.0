//
//  FrequentlyAskedModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/29/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

internal struct FrequentlyAskedModel: Codable, DictionaryCodable {
    
    enum Keys: String {
        case question
        case answer
    }
    
    var question: String
    var answer: String
    
    init(question: String, answer: String) {
        self.question = question
        self.answer = answer
    }
    
    init(dataRecieved: NSDictionary) throws {
        guard
            let question = dataRecieved[Keys.question.rawValue] as? String,
            let answer = dataRecieved[Keys.answer.rawValue] as? String
        else {
            throw RuntimeException.dictionaryDecoding("Failed to parse faq")
        }
        
        self.question = question
        self.answer = answer
    }
}
