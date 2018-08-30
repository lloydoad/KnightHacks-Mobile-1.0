//
//  ScheduleTableViewController.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 8/28/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

class ScheduleTableViewController: UITableViewController {
    var upperViewColor: UIColor = BACKGROUND_COLOR
    var filterMenuCollectionViewReference: UICollectionView!
    var headerRowHeight: CGFloat = 80
    
    // Must override in child class
    var filterMenuOptions: Int = 5
    var otherRowHeight: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup navigation bar
        self.navigationController?.navigationBar.barTintColor = upperViewColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.largeTitleDisplayMode = .never
        
        // Setup tableview
        self.tableView.estimatedRowHeight = COMBINED_FILTER_HEIGHT - NAVBAR_HEIGHT - 10
        self.tableView.register(FilterMenuTableViewCell.self, forCellReuseIdentifier: FilterMenuTableViewCell.identifier)
        self.view.backgroundColor = .white
        colorBounceView(with: upperViewColor)
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





