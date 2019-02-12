//
//  FilteredParentTableView.swift
//  KnightHacks
//
//  Created by KnightHacks on 8/28/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

protocol FilteredParentTableViewDelegate {
    func setFilterMenuCellContents() -> [FilterButton]
    func setTableViewCellContents() -> [Int:[Any]]
    func setTableViewHeaderTitles() -> [String]
}

class FilteredParentTableView: ParentTableView, UICollectionViewDelegate {
    
    var headerRowHeight: CGFloat = 60
    var isBarAnimationComplete: Bool = false
    var estimatedNumberOfFilterButtons: CGFloat = 5
    var filterMenu: FilterMenuCollectionViewController!
    var flowlayout: UICollectionViewFlowLayout!
    
    // protocol variables
    var childDelegate: FilteredParentTableViewDelegate?
    var filterButtons: [FilterButton] = []
    var tableViewCellContents: [Int : [Any]] = [:]
    var tableViewHeaderTitles: [String] = []
    
    // add or remove headers
    var hasHeaders: Bool = true {
        didSet {
            tableView.reloadData()
        }
    }
    
    override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .horizontal
        flowlayout.itemSize = CGSize(width: FILTER_MENU_HEIGHT - 40, height: FILTER_MENU_HEIGHT - 20)
        
        filterMenu = FilterMenuCollectionViewController(
            frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: FILTER_MENU_HEIGHT),
            collectionViewLayout: flowlayout
        )
        filterMenu.delegate = self
        self.tableView.tableHeaderView = filterMenu
        
        reloadTableContent(withFilter: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        for (index,_) in filterButtons.enumerated() {
            filterMenu.deselectItem(at: IndexPath(row: index, section: 0), animated: false)
        }
    }

    func reloadTableContent(withFilter flag: Bool = false) {
        guard let delegate = childDelegate else {
            filterButtons = []
            tableViewCellContents = [:]
            tableViewHeaderTitles = []
            filterMenu.set(filters: filterButtons)
            
            super.tableView.reloadData()
            self.isEmpty = true
            return
        }
        
        if flag == true {
            filterButtons = delegate.setFilterMenuCellContents()
            filterMenu.set(filters: filterButtons)
        }
        
        tableViewCellContents = delegate.setTableViewCellContents()
        tableViewHeaderTitles = delegate.setTableViewHeaderTitles()
        
        super.tableView.reloadData()
        self.isEmpty = delegate.setTableViewCellContents().isEmpty ? true : false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // if initial screen load, filter menu
        if !isBarAnimationComplete {
            let lastIndexInCollectionView = IndexPath(row: filterButtons.count - 1, section: 0)
            self.filterMenu.scrollToItem(at: lastIndexInCollectionView, at: .right, animated: true)
            isBarAnimationComplete = true
        }
    }
}
