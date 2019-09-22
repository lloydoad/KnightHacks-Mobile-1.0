//
//  SponsorTableViewControllerModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/28/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

internal class SponsorTableViewControllerModel: FilterCollectionViewDataSource {
    
    var observer: ModelObserver?

    private var fetchedContent: [SponsorModel] = []
    private(set) var viewContent: [SponsorModel] = []
    
    var filterCollectionView: FilterCollectionView?
    var filters: [FilterMenuModel] = []
    
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
                    filters: dummySponsorFilterGroup.randomElement() ?? [] // currently being filled with dummy filters
                )
                
                parsed.filters.forEach {
                    necessaryFilters.insert($0)
                }
                
                self.fetchedContent.append(parsed)
            }
            
            self.filters = necessaryFilters + [FilterMenuModel(name: defaultAllFilter)]
            self.viewContent = self.fetchedContent
            
            self.observer?.didFetchModel()
            self.filterCollectionView?.performLoadingAnimation()
        }
    }
    
    func filterSponsorData(with filter: FilterMenuModel) {
        viewContent = filter.name == defaultAllFilter ? fetchedContent : fetchedContent.filter { $0.filters.contains(filter) }
        observer?.didFetchModel()
    }
}
