//
//  WorkshopTableViewControllerModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/25/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation
import UIKit

internal class WorkshopTableViewControllerModel: HeaderContentViewModel<WorkshopModel>, FilterCollectionViewDataSource {
    
    private let dateEngine = DateEngine(format: .standardISO1806)
    private let filterType = "workshop"
    
    var filterCollectionView: FilterCollectionView?
    var filters: [FilterMenuModel] = []
    
    func fetchWorkshopData() {
        
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate,
            let viewFilters = appdelegate.applicationFilters[self.filterType] {
            self.filters = viewFilters + [FilterMenuModel(name: FilterNames.all.rawValue)]
        } else {
            self.filters = [FilterMenuModel(name: FilterNames.all.rawValue)]
        }
        
        FirebaseRequestSingleton<WorkshopDictionaryModel>().makeRequest(endpoint: .workshops) { (dictonaryModels) in
            
            self.fetchedData = []
            
            guard !dictonaryModels.isEmpty else {
                self.fetchData()
                self.filterCollectionView?.performLoadingAnimation()
                return
            }
            
            var filterLookup: [String: FilterMenuModel] = [:]
            self.filters.forEach { filterLookup[$0.name] = $0 }
            
            dictonaryModels.forEach({ (workshopDictionaryModel) in
                let date = Date(timeIntervalSince1970: TimeInterval(integerLiteral: workshopDictionaryModel.date))
                
                var parsedValue = WorkshopModel(
                    date: date,
                    time: self.dateEngine.getString(of: date, as: .hourColonMinuteMeridian),
                    title: workshopDictionaryModel.name,
                    header: self.dateEngine.getString(of: date, as: .dayMonth),
                    imageURL: workshopDictionaryModel.imageURL,
                    description: workshopDictionaryModel.description,
                    filters: []
                )
                
                for filterName in workshopDictionaryModel.filters {
                    if let filterMenu = filterLookup[filterName] {
                        parsedValue.filters.append(filterMenu)
                    }
                }
                
                self.fetchedData.append(parsedValue)
            })
            
            self.fetchData()
            self.filterCollectionView?.performLoadingAnimation()
        }
    }
}
