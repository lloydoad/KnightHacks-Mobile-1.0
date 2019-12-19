//
//  FrequentlyAskedViewControllerModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/29/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

internal class FrequentlyAskedViewControllerModel {
    
    var observer: ModelObserver?
    
    private var fetchedData: [FrequentlyAskedModel] = []
    private(set) var viewContent: [FrequentlyAskedModel] = []
    
    func fetchFrequentlyAskedData() {
        FirebaseRequestSingleton<FrequentlyAskedModel>().makeRequest(endpoint: .faqs) { (results) in
            guard !results.isEmpty else {
                self.fetchedData = []
                self.viewContent = self.fetchedData.map { FrequentlyAskedModel(question: $0.question, answer: "")}
                self.observer?.didFetchModel()
                return
            }
            
            self.fetchedData = results
            self.viewContent = self.fetchedData.map { FrequentlyAskedModel(question: $0.question, answer: "")}
            self.observer?.didFetchModel()
        }
    }
    
    func toggleQuestion(at index: Int) {
        guard index < viewContent.count else { return }
        viewContent[index].answer = viewContent[index].answer == "" ? fetchedData[index].answer : ""
    }
}
