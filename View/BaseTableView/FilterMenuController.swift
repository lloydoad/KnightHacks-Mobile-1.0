//
//  FilterMenuCollectionViewController.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 8/29/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

extension CustomTableViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filterMenuCollectionViewReference.dequeueReusableCell(withReuseIdentifier: FilterButtonCollectionViewCell.identifier, for: indexPath) as! FilterButtonCollectionViewCell
        cell.isSelected = false
        
        cell.insetImageContainer.image = filterOptions[indexPath.row].image
        cell.customLabel.text = filterOptions[indexPath.row].name.capitalized
        
        return cell
    }
}
