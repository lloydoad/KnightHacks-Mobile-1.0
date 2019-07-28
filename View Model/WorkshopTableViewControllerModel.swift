//
//  WorkshopTableViewControllerModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/25/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

internal class WorkshopTableViewControllerModel: HeaderContentViewModel<WorkshopModel> {
    
    private(set) var filters: [FilterMenuModel] = [
        FilterMenuModel(type: .hardware),
        FilterMenuModel(type: .beginner),
        FilterMenuModel(type: .advanced),
        FilterMenuModel(type: .career),
        FilterMenuModel(type: .design),
        FilterMenuModel(type: .development),
        FilterMenuModel(type: .all)
    ]
    
    func fetchWorkshopData() {
        // make network call
        fetchedData = WorkshopDummyData
        fetchData()
    }
}
