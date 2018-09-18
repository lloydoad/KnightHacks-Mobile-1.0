//
//  ScheduleTableViewController.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 8/28/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

class FilteredParentTableView: ParentTableView {
    var filterMenuCollectionViewReference: UICollectionView!
    var headerRowHeight: CGFloat = 60
    var isBarAnimationComplete: Bool = false
    var hasHeaders: Bool = true
    
    // Must override in child class
    var filterOptions: [FilterButton] = []
    var tableDataContent: [(String,[Int])] = []
    
    init(style: UITableViewStyle, filterOptions: [FilterButton], content: [(String,[Int])] = [("",[])]) {
        super.init(style: style)
        self.filterOptions = filterOptions
        self.tableDataContent = content
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register separate cells
        tableView.register(FilterMenuTableViewCell.self, forCellReuseIdentifier: FilterMenuTableViewCell.identifier)
        
        self.view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !isBarAnimationComplete {
            // Push filter menu behind navigation bar
            let offsetOfFilterMenu = CGPoint(x: 0, y: COMBINED_FILTER_HEIGHT - NAVBAR_HEIGHT - 10)
            self.tableView.setContentOffset(offsetOfFilterMenu, animated: false)
            self.view.layoutIfNeeded()
        }
    }
    
    // Smooth out filter menu transition
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // if initial screen load, scroll table and filter menu
        if !isBarAnimationComplete {
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            let lastIndexInCollectionView = IndexPath(row: filterOptions.count - 1, section: 0)
            self.filterMenuCollectionViewReference.scrollToItem(at: lastIndexInCollectionView, at: .right, animated: true)
            isBarAnimationComplete = true
        }
    }
}





