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
        FirebaseRequestSingleton<LiveUpdateModel>().makeRequest(endpoint: .liveUpdates) { (results) in
            guard !results.isEmpty else {
                self.fetchRecent()
                return
            }
            
            var fetchedData: [LiveUpdateModel] = results
            
            fetchedData.sort()
            fetchedData.reverse()
            self.viewContent = fetchedData
            self.observer?.didFetchModel()
        }
    }
}
