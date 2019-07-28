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
        // network call
        fetchedContent = dummySponsorData
        
        viewContent = fetchedContent
        observer?.didFetchModel()
    }
    
    func filterSponsorData(with filter: FilterNames) {
        viewContent = filter == .all ? fetchedContent : fetchedContent.filter {$0.filters.contains(filter)}
        observer?.didFetchModel()
    }
}
