//
//  ScheduleTableViewControllerModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/21/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

internal class ScheduleTableViewControllerModel: HeaderContentViewModel<ScheduleModel>, FilterCollectionViewDataSource {
    
    private let dateEngine = DateEngine(format: .standardISO1806)
    internal static let filterType = "event"
    
    var filterCollectionView: FilterCollectionView?
    var filters: [FilterMenuModel] = []
    
    func fetchScheduleData() {
        
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate,
            let viewFilters = appdelegate.applicationFilters[ScheduleTableViewControllerModel.filterType] {
            self.filters = viewFilters + [FilterMenuModel(name: FilterNames.all.rawValue)]
        } else {
            self.filters = [FilterMenuModel(name: FilterNames.all.rawValue)]
        }
        
        FirebaseRequestSingleton<ScheduleModel>().makeRequest(endpoint: .events) { (dictonaryModels) in
            
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
