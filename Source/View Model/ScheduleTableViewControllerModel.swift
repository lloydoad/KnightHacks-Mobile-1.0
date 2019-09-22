//
//  ScheduleTableViewControllerModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/21/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

internal class ScheduleTableViewControllerModel: HeaderContentViewModel<ScheduleModel>, FilterCollectionViewDataSource {
    
    private let dateEngine = DateEngine(format: .standardISO1806)
    
    var filterCollectionView: FilterCollectionView?
    var filters: [FilterMenuModel] = []
    
    func fetchScheduleData() {
        let requestSingleton = RequestSingleton<CodableScheduleModel>()
        requestSingleton.makeRequest(url: requestSingleton.scheduleURL) { (results) in
            
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
                
                let parsed = ScheduleModel(
                    title: value.title,
                    location: value.location,
                    time: self.dateEngine.getString(of: date, as: .hourColonMinuteMeridian),
                    header: self.dateEngine.getString(of: date, as: .dayMonth),
                    date: date,
                    filters: dummyScheduleFilterGroup.randomElement() ?? [] // currently being filled with dummy filters
                )
                
                parsed.filters.forEach {
                    necessaryFilters.insert($0)
                }
                
                self.fetchedData.append(parsed)
            }
            
            self.filters = necessaryFilters + [FilterMenuModel(name: FilterNames.all.rawValue)]
            
            self.fetchData()
            self.filterCollectionView?.performLoadingAnimation()
        }
    }
}
