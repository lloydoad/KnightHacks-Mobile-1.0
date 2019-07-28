//
//  HeaderDataSource.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/21/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

/**
 Datasource protocol used to indicate inheriting class contains header type behavior
 */
internal protocol HeaderDataSource {
    var header: String { get set }
}
