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
        return tableDataContent.count + 1
    }
    
    // return number of events + filter menu
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return tableDataContent[section - 1].1.count
        }
    }
    
    // set height for header
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || hasHeaders == false {
            return 0
        } else {
            return headerRowHeight
        }
    }
    
    // title for headers
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if hasHeaders {
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
            let customHeaderView = UIVisualEffectView(effect: blurEffect)
            customHeaderView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: headerRowHeight)
            customHeaderView.alpha = 0.9
            let headerLabel = UILabel()
            headerLabel.font = UIFont.systemFont(ofSize: 36)
            headerLabel.text = tableDataContent[section - 1].0.capitalized
            headerLabel.translatesAutoresizingMaskIntoConstraints = false
            
            customHeaderView.contentView.addSubview(headerLabel)
            headerLabel.centerYAnchor.constraint(equalTo: customHeaderView.contentView.centerYAnchor).isActive = true
            headerLabel.leadingAnchor.constraint(equalTo: customHeaderView.contentView.leadingAnchor, constant: 38).isActive = true
            return customHeaderView
        } else {
            return nil
        }
    }
    
    // MARK: - TABLE DELEGATE FUNCTIONS
}
