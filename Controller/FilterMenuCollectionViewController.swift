//
//  FilterMenuCollectionViewController.swift
//  KnightHacks
//
//  Created by KnightHacks on 1/14/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

class FilterMenuCollectionViewController: UICollectionView, UICollectionViewDataSource {
    private var filterButtons: [FilterButton] = [] {
        didSet {
            self.reloadData()
        }
    }
    override var numberOfSections: Int {
        return filterButtons.isEmpty ? 0 : 1
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = BACKGROUND_COLOR
        self.dataSource = self
        self.showsHorizontalScrollIndicator = false
        self.isScrollEnabled = true
        
        self.contentInset = UIEdgeInsets(top: 5, left: 20, bottom: 3, right: 20)
        
        self.register(FilterMenuButtonCollectionViewCell.self, forCellWithReuseIdentifier: FilterMenuButtonCollectionViewCell.identifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func set(filters: [FilterButton]) {
        self.filterButtons = filters
    }
    
    public func getFilters() -> [FilterButton] {
        return self.filterButtons
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterButtons.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: FilterMenuButtonCollectionViewCell.identifier, for: indexPath) as! FilterMenuButtonCollectionViewCell
        cell.isSelected = false

        cell.filterMenuButtonImageView.image = filterButtons[indexPath.row].image
        cell.filterMenuButtonLabel.text = filterButtons[indexPath.row].name.capitalized

        return cell
    }
}
