//
//  ScheduleTableViewControllerModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/21/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

internal class ScheduleTableViewControllerModel: HeaderContentViewModel<ScheduleModel> {
    
    private(set) var filters: [FilterMenuModel] = [
        FilterMenuModel(type: .food),
        FilterMenuModel(type: .talk),
        FilterMenuModel(type: .workshop),
        FilterMenuModel(type: .mainEvent),
        FilterMenuModel(type: .all)
    ]
    
    func fetchScheduleData() {
        // make network call
        fetchedData = dummyScheduleData
        fetchData()
    }
}
