//
//  FilterMenuTableViewCell.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 8/28/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

class FilterMenuTableViewCell: UITableViewCell {
    static var identifier = "FilterMenuTableViewCell"
    
    let filterMenuHeight: CGFloat = COMBINED_FILTER_HEIGHT - NAVBAR_HEIGHT
    
    var filterMenuCollectionView: UICollectionView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Flowlayout to handle scroll and contentSize
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .horizontal
        flowlayout.itemSize = CGSize(width: filterMenuHeight - 40, height: filterMenuHeight - 20)
        
        createFilterMenu(withLayout: flowlayout)
        setConstraintForFilterMenu()
        
        self.selectionStyle = .none
        separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        
        filterMenuCollectionView.register(FilterMenuButtonCollectionViewCell.self, forCellWithReuseIdentifier: FilterMenuButtonCollectionViewCell.identifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createFilterMenu(withLayout layout: UICollectionViewLayout) {
        filterMenuCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: contentView.bounds.width, height: filterMenuHeight), collectionViewLayout: layout)
        filterMenuCollectionView.isScrollEnabled = true
        filterMenuCollectionView.backgroundColor = BACKGROUND_COLOR
        filterMenuCollectionView.contentInset = UIEdgeInsets(top: 5, left: 20, bottom: 3, right: 20)
    }
    
    func setConstraintForFilterMenu() {
        self.contentView.addSubview(filterMenuCollectionView)
        filterMenuCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filterMenuCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        filterMenuCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        filterMenuCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        filterMenuCollectionView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
    }
}
