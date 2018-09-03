//
//  ScheduleTableViewController.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 8/28/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

class CustomTableViewController: UITableViewController {
    var upperViewColor: UIColor = BACKGROUND_COLOR
    var filterMenuCollectionViewReference: UICollectionView!
    var headerRowHeight: CGFloat = 80
    var isBarAnimationComplete: Bool = false
    
    // Must override in child class
    var otherRowHeight: CGFloat!
    var numberOfRows: Int!
    var filterOptions: [FilterButton] = []
    
    init(style: UITableViewStyle, filterOptions: [FilterButton], rowHeight: CGFloat, rowCount: Int) {
        super.init(style: style)
        self.filterOptions = filterOptions
        self.numberOfRows = rowCount
        self.otherRowHeight = rowHeight
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup tableview
        self.tableView.estimatedRowHeight = COMBINED_FILTER_HEIGHT - NAVBAR_HEIGHT - 10
        self.tableView.register(FilterMenuTableViewCell.self, forCellReuseIdentifier: FilterMenuTableViewCell.identifier)
        tableView.register(EventItemCell.self, forCellReuseIdentifier: EventItemCell.identifier)
        self.view.backgroundColor = .white
        colorBounceView(with: upperViewColor)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Setup navigation bar
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = upperViewColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.largeTitleDisplayMode = .never
        
        if !isBarAnimationComplete {
            self.tableView.setContentOffset(CGPoint(x: 0, y: COMBINED_FILTER_HEIGHT - NAVBAR_HEIGHT), animated: false)
            self.view.layoutIfNeeded()
        }
    }
    
    // Smooth out filter menu transition
    override func viewDidAppear(_ animated: Bool) {
        if !isBarAnimationComplete {
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            isBarAnimationComplete = true
        }
    }
    
    // Change the color of space between tablview and navbar
    func colorBounceView(with color: UIColor) {
        var frame = self.view.bounds
        frame.origin.y = -frame.size.height

        let view = UIView(frame: frame)
        view.backgroundColor = color

        self.view.addSubview(view)
    }
    
    // MARK: - NAVIGATION
    override func willMove(toParentViewController parent: UIViewController?) {
        self.navigationController?.navigationBar.barTintColor = .white
    }
}





