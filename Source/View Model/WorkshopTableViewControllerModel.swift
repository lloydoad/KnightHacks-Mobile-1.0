//
//  WorkshopTableViewControllerModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/25/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

internal class WorkshopTableViewControllerModel: HeaderContentViewModel<WorkshopModel>, FilterCollectionViewDataSource {
    
    private let dateEngine = DateEngine(format: .standardISO1806)
    internal static let filterType = "workshop"
    
    var filterCollectionView: FilterCollectionView?
    var filters: [FilterMenuModel] = []
    
    func fetchWorkshopData() {
        
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate,
            let viewFilters = appdelegate.applicationFilters[WorkshopTableViewControllerModel.filterType] {
            self.filters = viewFilters + [FilterMenuModel(name: FilterNames.all.rawValue)]
        } else {
            self.filters = [FilterMenuModel(name: FilterNames.all.rawValue)]
        }
        
        FirebaseRequestSingleton<WorkshopModel>().makeRequest(endpoint: .workshops) { (dictonaryModels) in
            
            self.fetchedData = []
            
            guard !dictonaryModels.isEmpty else {
                self.fetchData()
                self.filterCollectionView?.performLoadingAnimation()
                return
            }
            
            self.fetchedData = dictonaryModels
            
            self.fetchData()
            self.filterCollectionView?.performLoadingAnimation()
        }
    }
}
