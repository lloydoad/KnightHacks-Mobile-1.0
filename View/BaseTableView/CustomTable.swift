//
//  CustomTableViewController.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 8/29/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

extension CustomTableViewController {
    // MARK: - TABLE DATASOURCE FUNCTIONS
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 && indexPath.section == 0{
            let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: FilterMenuTableViewCell.identifier, for: indexPath) as! FilterMenuTableViewCell
            filterMenuCollectionViewReference = dequeuedCell.filterMenuCollectionView
            filterMenuCollectionViewReference.delegate = self
            filterMenuCollectionViewReference.dataSource = self
            let totalLength: CGFloat = (COMBINED_FILTER_HEIGHT - NAVBAR_HEIGHT - 30) * 5
            filterMenuCollectionViewReference.contentSize = CGSize(width: totalLength, height: totalLength)
            return dequeuedCell
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell.textLabel?.text = "NOT FORMATTED"
            return cell
        }
    }
    
    // return a customized height for filter menu cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return COMBINED_FILTER_HEIGHT - NAVBAR_HEIGHT
        } else {
            return otherRowHeight
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // return number of events + filter menu
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return numberOfRows
        }
    }
    
    // MARK: - TABLE DELEGATE FUNCTIONS
}
