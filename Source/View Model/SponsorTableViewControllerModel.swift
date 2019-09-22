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
        FilterMenuModel(name: FilterNames.all.rawValue)
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
            
            var necessaryFilters: Set<FilterMenuModel> = Set()
            
            for value in results {
                
                let parsed = SponsorModel(
                    name: value.name,
                    location: value.location,
                    imageURL: value.imageURL,
                    description: value.description,
                    filters: dummySponsorFilterGroup.randomElement() ?? []
                )
                
                parsed.filters.forEach {
                    necessaryFilters.insert($0)
                }
                
                self.fetchedContent.append(parsed)
            }
            
            self.filters.append(contentsOf: necessaryFilters)
            self.filters.append(FilterMenuModel(name: defaultAllFilter))
            
            self.viewContent = self.fetchedContent
            self.observer?.didFetchModel()
        }
    }
    
    func filterSponsorData(with filter: FilterMenuModel) {
        viewContent = filter.name == defaultAllFilter ? fetchedContent : fetchedContent.filter { $0.filters.contains(filter) }
        observer?.didFetchModel()
    }
}
