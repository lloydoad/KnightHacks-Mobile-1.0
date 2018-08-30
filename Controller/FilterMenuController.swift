//
//  FilterMenuCollectionViewController.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 8/29/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

extension ScheduleTableViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterMenuOptions
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filterMenuCollectionViewReference.dequeueReusableCell(withReuseIdentifier: FilterButtonCollectionViewCell.identifier, for: indexPath)
        cell.isSelected = false
        return cell
    }
}
