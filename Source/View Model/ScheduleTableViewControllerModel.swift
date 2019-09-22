//
//  ScheduleTableViewControllerModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/21/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

internal class ScheduleTableViewControllerModel: HeaderContentViewModel<ScheduleModel> {
    
    private let dateEngine = DateEngine(format: .standardISO1806)
    
    private(set) var filters: [FilterMenuModel] = []
    
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
                    filters: dummyScheduleFilterGroup.randomElement() ?? []
                )
                
                parsed.filters.forEach {
                    necessaryFilters.insert($0)
                }
                
                self.fetchedData.append(parsed)
            }
            
            self.filters.append(contentsOf: necessaryFilters)
            self.filters.append(FilterMenuModel(name: FilterNames.all.rawValue))
            
            self.fetchData()
        }
    }
}
