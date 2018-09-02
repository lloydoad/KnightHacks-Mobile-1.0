//
//  FilterMenuTableViewCell.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 8/28/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

class FilterMenuTableViewCell: UITableViewCell {
    static var identifier = "FilterMenuTableViewCell"
    var filterMenuCollectionView: UICollectionView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupView() {
        // Height of menu is phone dependant
        let filterMenuHeight: CGFloat = COMBINED_FILTER_HEIGHT - NAVBAR_HEIGHT
        
        // Flowlayout to handle scroll and contentSize
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .horizontal
        flowlayout.itemSize = CGSize(width: filterMenuHeight - 40, height: filterMenuHeight - 20)
        
        // Make, register and customize collection view for filter buttons
        filterMenuCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: contentView.bounds.width, height: filterMenuHeight), collectionViewLayout: flowlayout)
        filterMenuCollectionView.register(FilterButtonCollectionViewCell.self, forCellWithReuseIdentifier: FilterButtonCollectionViewCell.identifier)
        filterMenuCollectionView.isScrollEnabled = true
        filterMenuCollectionView.alpha = 1
        filterMenuCollectionView.backgroundColor = BACKGROUND_COLOR
        
        // Constraints to handle size and position
        contentView.addSubview(filterMenuCollectionView)
        filterMenuCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filterMenuCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        filterMenuCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        filterMenuCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        filterMenuCollectionView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
    }
}
