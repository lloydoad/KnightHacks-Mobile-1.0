//
//  FilterTableRequirements.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 6/27/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

/**
 A protocol with abstractions for adding common features to a tableview which intends to implement the filter menu feature
 - These functions are not required and must be called explicitly if needed
 */
public protocol FilterCollectionViewExtension: UITableViewDelegate, UITableViewDataSource, FilterCollectionViewDataSource, FilterCollectionViewDelegate { }

public extension FilterCollectionViewExtension {
    /**
     Creates and returns a filter menu (Filter Collection View) which has already been sized and placed in the provided tableview header
     */
    func addFilterCollectionView(to table: UITableView) -> FilterCollectionView {
        let frame = CGRect(x: 0, y: 0, width: table.frame.width, height: FilterCollectionView.minimumRequiredHeight)
        let filterCollectionView = FilterCollectionView(frame: frame)
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self
        table.tableHeaderView = filterCollectionView
        return filterCollectionView
    }
}
