//
//  CustomTableViewController.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 8/29/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

extension ScheduleTableViewController {
    // MARK: - TABLE DATASOURCE FUNCTIONS
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        if indexPath.row == 0 {
            let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: FilterMenuTableViewCell.identifier, for: indexPath) as! FilterMenuTableViewCell
            filterMenuCollectionViewReference = dequeuedCell.filterMenuCollectionView
            filterMenuCollectionViewReference.backgroundColor = upperViewColor
            filterMenuCollectionViewReference.delegate = self
            filterMenuCollectionViewReference.dataSource = self
            let totalLength: CGFloat = (COMBINED_FILTER_HEIGHT - NAVBAR_HEIGHT - 30) * 5
            filterMenuCollectionViewReference.contentSize = CGSize(width: totalLength, height: totalLength)
            cell = dequeuedCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell.textLabel?.text = "TEST"
        }
        
        return cell
    }
    
    // return a customized height for filter menu cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return COMBINED_FILTER_HEIGHT - NAVBAR_HEIGHT
        } else {
            return otherRowHeight
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // return number of events + filter menu
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    // MARK: - TABLE DELEGATE FUNCTIONS
}
