//
//  WorkshopsViewController.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 9/6/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

class WorkshopsViewController: FilteredParentTableView {
    let tags: [String] = ["default 1", "default 2"]
    
    // Make changes to default view settings
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //        update model with api
        //        tableDataContent = sampleRetrievedData
        //        otherRowHeight = 107
    }
    
    // Override cells excluding filter menu cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DynamicTableViewCell.identifier, for: indexPath) as! DynamicTableViewCell
            cell.cellType = .detailedCell
            cell.contentImageView?.image = UIImage(named: "knight hacks image")
            for tag in tags {
                cell.addNewTag(tag: tag)
            }
            cell.selectionStyle = .none
            return cell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
}
