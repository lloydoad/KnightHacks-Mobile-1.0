//
//  SponsorTableViewControllerModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/28/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

internal class SponsorTableViewControllerModel: FilterCollectionViewDataSource {
    
    var observer: ModelObserver?
    internal static let filterType = "sponsor"

    private var fetchedContent: [SponsorModel] = []
    private(set) var viewContent: [SponsorModel] = []
    
    var filterCollectionView: FilterCollectionView?
    var filters: [FilterMenuModel] = []
    
    func fetchSponsorData() {
        
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate,
            let viewFilters = appdelegate.applicationFilters[SponsorTableViewControllerModel.filterType] {
            self.filters = viewFilters + [FilterMenuModel(name: FilterNames.all.rawValue)]
        } else {
            self.filters = [FilterMenuModel(name: FilterNames.all.rawValue)]
        }
        
        FirebaseRequestSingleton<SponsorModel>().makeRequest(endpoint: .sponsors) { (dictonaryModels) in
            
            self.fetchedContent = []
            guard !dictonaryModels.isEmpty else {
                self.viewContent = self.fetchedContent
                self.observer?.didFetchModel()
                return
            }
            
            self.fetchedContent = dictonaryModels
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
