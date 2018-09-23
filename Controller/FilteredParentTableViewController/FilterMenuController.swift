//
//  FilterMenuCollectionViewController.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 8/29/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

extension FilteredParentTableView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterButtons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filterMenuCollectionViewReference.dequeueReusableCell(withReuseIdentifier: FilterMenuButtonCollectionViewCell.identifier, for: indexPath) as! FilterMenuButtonCollectionViewCell
        cell.isSelected = false
        
        cell.filterMenuButtonImageView.image = filterButtons[indexPath.row].image
        cell.filterMenuButtonLabel.text = filterButtons[indexPath.row].name.capitalized
                
        return cell
    }
}
