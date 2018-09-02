//
//  ScheduleViewController.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 9/1/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

class ScheduleViewController: CustomTableViewController {
    var sampleData: [Int] = [1,1,1,1,1]
    
    // Make changes to default view settings
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // remove seperators
        tableView.separatorStyle = .none
        
        // update model with api
        numberOfRows = sampleData.count
        otherRowHeight = 107
        // set data retrieved from api
    }
    
    // Override cells excluding filter menu cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EventItemCell.identifier, for: indexPath) as! EventItemCell
            cell.selectionStyle = .none
            return cell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let customHeaderView = UIVisualEffectView(effect: blurEffect)
        customHeaderView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 60)
        customHeaderView.alpha = 0.9
        let headerLabel = UILabel()
        headerLabel.font = UIFont.systemFont(ofSize: 36)
        headerLabel.text = "Example"
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        customHeaderView.contentView.addSubview(headerLabel)
        headerLabel.centerYAnchor.constraint(equalTo: customHeaderView.contentView.centerYAnchor).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: customHeaderView.contentView.leadingAnchor, constant: 38).isActive = true
        return customHeaderView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 60
        }
    }
}
