//
//  FilterDataSource.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/21/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

/**
 Datasource protocol used to indicate inheriting class contains filter type behavior
 */
internal protocol FilterDataSource {
    var filters: [FilterMenuModel] { get set }
}
