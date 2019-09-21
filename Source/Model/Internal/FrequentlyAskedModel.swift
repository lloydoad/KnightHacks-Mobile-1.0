//
//  FrequentlyAskedModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/29/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

internal struct FrequentlyAskedModel: Codable {
    
    var question: String
    var answer: String
    
    init(question: String, answer: String) {
        self.question = question
        self.answer = answer
    }
}
