//
//  LiveUpdateTableViewControllerModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/25/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

internal class LiveUpdateTableViewControllerModel {
    
    var observer: ModelObserver?
    
    private let dateEngine = DateEngine(format: .standardISO1806)
    
    private(set) var viewContent: [LiveUpdateModel] = []
    
    func fetchRecent() {
        let requestSingleton = RequestSingleton<CodableLiveUpdateModel>()
        requestSingleton.makeRequest(url: requestSingleton.liveUpdateURL) { (results) in
            
            guard let results = results, !results.isEmpty else {
                self.fetchRecent()
                return
            }
            
            var fetchedData: [LiveUpdateModel] = []
            for value in results {
                
                guard let date = self.dateEngine.getDate(from: value.date) else {
                    continue
                }
                
                fetchedData.append(
                    LiveUpdateModel(
                        title: value.description,
                        date: date,
                        time: self.dateEngine.getString(of: date, as: .hourColonMinuteMeridian),
                        imageURL: value.imageURL
                    )
                )
            }
            
            fetchedData.sort()
            fetchedData.reverse()
            self.viewContent = fetchedData
            self.observer?.didFetchModel()
        }
    }
}
