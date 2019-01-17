//
//  FilreredParentTableViewExtension.swift
//  KnightHacks
//
//  Created by KnightHacks on 8/29/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

extension FilteredParentTableView {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = "NOT FORMATTED"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewCellContents.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewCellContents[section]?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if hasHeaders == false {
            return 0
        } else {
            return headerRowHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if hasHeaders && (section < tableViewHeaderTitles.count) {
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
        headerLabel.text = tableViewHeaderTitles[section].capitalized
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        customHeaderView.contentView.addSubview(headerLabel)
        headerLabel.centerYAnchor.constraint(equalTo: customHeaderView.contentView.centerYAnchor).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: customHeaderView.contentView.leadingAnchor, constant: 38).isActive = true
        
        return customHeaderView
    }
}
