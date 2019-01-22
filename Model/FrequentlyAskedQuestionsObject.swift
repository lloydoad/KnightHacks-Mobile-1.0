//
//  FrequentlyAskedQuestionsObject.swift
//  KnightHacks
//
<<<<<<< HEAD
//  Created by Jamal Yauhari on 1/15/19.
//  Copyright © 2019 Lloyd Dapaah. All rights reserved.
=======
//  Created by KnightHacks on 1/15/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
>>>>>>> 91e7bddfa371482701ed4702f2686f0256f53fac
//

import Foundation
import SwiftyJSON

class FrequentlyAskedQuestionsObject {
    
    static let API_QUESTION_PARAMETER_KEY = "question"
    static let API_ANSWER_PARAMETER_KEY = "answer"
    
    var question: String
    var answer: String
    
    init(question: String, answer: String) {
        self.question = question
        self.answer = answer
    }
    
    init(json: JSON) {
        question = json[FrequentlyAskedQuestionsObject.API_QUESTION_PARAMETER_KEY].stringValue
        answer = json[FrequentlyAskedQuestionsObject.API_ANSWER_PARAMETER_KEY].stringValue
    }
}
