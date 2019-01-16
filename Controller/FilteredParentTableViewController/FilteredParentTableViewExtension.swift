//
//  FilreredParentTableViewExtension.swift
//  KnightHacks
//
//  Created by KnightHacks on 8/29/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

extension FilteredParentTableView {
    // setup filter menu button in top cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 && indexPath.section == 0{
            return addFilterMenu(inCellForRowAt: indexPath)
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell.textLabel?.text = "NOT FORMATTED"
            return cell
        }
    }
    
    func addFilterMenu(inCellForRowAt indexpath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: FilterMenuTableViewCell.identifier, for: indexpath) as! FilterMenuTableViewCell
        filterMenuCollectionViewReference = dequeuedCell.filterMenuCollectionView
        filterMenuCollectionViewReference.delegate = self
        filterMenuCollectionViewReference.dataSource = self
        
        let estimatedContentViewLength: CGFloat = (COMBINED_FILTER_HEIGHT - NAVBAR_HEIGHT - 30) * estimatedNumberOfFilterButtons
        filterMenuCollectionViewReference.contentSize = CGSize(width: estimatedContentViewLength, height: estimatedContentViewLength)
        return dequeuedCell
    }
    
    // return a customized height for filter menu cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return COMBINED_FILTER_HEIGHT - NAVBAR_HEIGHT
        } else {
            return tableView.estimatedRowHeight
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewCellContents.count + 1
    }
    
    // return number of events + filter menu
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.tableViewCellContents[section - 1]!.count
        }
    }
    
    // set height for headers
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || hasHeaders == false {
            return 0
        } else {
            return headerRowHeight
        }
    }
    
    // set title for headers
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (hasHeaders || section > 0) && (section - 1 < tableViewHeaderTitles.count) {
            return getCustomView(forHeaderInSection: section)
        } else {
            return nil
        }
    }
    
    func getCustomView(forHeaderInSection section: Int) -> UIView {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let customHeaderView = UIVisualEffectView(effect: blurEffect)
        customHeaderView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: headerRowHeight)
        customHeaderView.alpha = 0.9
        
        let headerLabel = UILabel()
        headerLabel.font = CELL_HEADER_FONT
        headerLabel.text = tableViewHeaderTitles[section - 1].capitalized
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        customHeaderView.contentView.addSubview(headerLabel)
        headerLabel.centerYAnchor.constraint(equalTo: customHeaderView.contentView.centerYAnchor).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: customHeaderView.contentView.leadingAnchor, constant: 38).isActive = true
        
        return customHeaderView
    }
}
