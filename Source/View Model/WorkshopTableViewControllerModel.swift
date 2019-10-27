//
//  WorkshopTableViewControllerModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/25/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

internal class WorkshopTableViewControllerModel: HeaderContentViewModel<WorkshopModel>, FilterCollectionViewDataSource {
    
    private let dateEngine = DateEngine(format: .standardISO1806)
    
    var filterCollectionView: FilterCollectionView?
    var filters: [FilterMenuModel] = []
    
    func fetchWorkshopData() {
        let requestSingleton = RequestSingleton<CodableWorkshopModel>()
        requestSingleton.makeRequest(url: requestSingleton.workshopURL) { (results) in
            
            guard let results = results, !results.isEmpty else {
                self.fetchedData = []
                self.fetchData()
                return
            }
            
            var necessaryFilters: Set<FilterMenuModel> = Set()
            
            for value in results {
                
                guard let date = self.dateEngine.getDate(from: value.date) else {
                    continue
                }
                
                let parsedValue = WorkshopModel(
                    date: date,
                    time: self.dateEngine.getString(of: date, as: .hourColonMinuteMeridian),
                    title: value.name,
                    header: self.dateEngine.getString(of: date, as: .dayMonth),
                    imageURL: value.imageURL,
                    description: value.description,
                    filters: value.filters.map {
                        FilterMenuModel(codable: $0)
                    }
                )
                
                parsedValue.filters.forEach {
                    necessaryFilters.insert($0)
                }
                
                self.fetchedData.append(parsedValue)
            }
            
            self.filters = necessaryFilters + [FilterMenuModel(name: FilterNames.all.rawValue)]
            
            self.fetchData()
            self.filterCollectionView?.performLoadingAnimation()
        }
    }
}
