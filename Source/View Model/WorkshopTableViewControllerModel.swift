//
//  WorkshopTableViewControllerModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/25/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

internal class WorkshopTableViewControllerModel: HeaderContentViewModel<WorkshopModel> {
    
    private let dateEngine = DateEngine(format: .standardISO1806)
    
    private(set) var filters: [FilterMenuModel] = [
        FilterMenuModel(name: FilterNames.all.rawValue)
    ]
    
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
                    filters: dummyWorkshopFilterGroup.randomElement() ?? [] // update filter array
                )
                
                parsedValue.filters.forEach {
                    necessaryFilters.insert($0)
                }
                
                self.fetchedData.append(parsedValue)
            }
            
            self.filters.append(contentsOf: necessaryFilters)
            self.filters.append(FilterMenuModel(name: FilterNames.all.rawValue))
            
            self.fetchData()
        }
    }
}
