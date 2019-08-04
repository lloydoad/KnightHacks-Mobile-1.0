//
//  SponsorTableViewControllerModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/28/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

internal class SponsorTableViewControllerModel {
    
    var observer: ModelObserver?

    private var fetchedContent: [SponsorModel] = []
    private(set) var viewContent: [SponsorModel] = []
    
    private(set) var filters: [FilterMenuModel] = [
        FilterMenuModel(type: .partTime),
        FilterMenuModel(type: .internships),
        FilterMenuModel(type: .fullTime),
        FilterMenuModel(type: .all)
    ]
    
    func fetchSponsorData() {
        
        let requestSingleton = RequestSingleton<CodableSponsorModel>()
        requestSingleton.makeRequest(url: requestSingleton.sponsorURL) { (results) in
            
            guard let results = results, !results.isEmpty else {
                self.fetchedContent = []
                self.viewContent = self.fetchedContent
                self.observer?.didFetchModel()
                return
            }
            
            for value in results {
                
                var parsed = SponsorModel(
                    name: value.name,
                    location: value.location,
                    imageURL: value.imageURL,
                    description: value.description,
                    filters: []
                )
                
                value.filters.forEach {
                    if let filter = FilterNames(rawValue: $0) {
                        parsed.filters.append(filter)
                    }
                }
                
                self.fetchedContent.append(parsed)
            }
            
            self.viewContent = self.fetchedContent
            self.observer?.didFetchModel()
        }
    }
    
    func filterSponsorData(with filter: FilterNames) {
        viewContent = filter == .all ? fetchedContent : fetchedContent.filter {$0.filters.contains(filter)}
        observer?.didFetchModel()
    }
}
