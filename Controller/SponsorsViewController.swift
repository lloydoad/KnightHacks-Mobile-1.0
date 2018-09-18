//
//  SponsorsViewController.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 9/6/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

class SponsorsViewController: FilteredParentTableView {
    // temp array to represent loaded tags
    let tags: [String] = ["default 1", "default 2"]
    
    // Make changes to default view settings
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // remove headers
        hasHeaders = false
        
        //        update model with api
        //        tableDataContent = sampleRetrievedData
    }
    
    // Override cells excluding filter menu cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DynamicTableViewCell.identifier, for: indexPath) as! DynamicTableViewCell
            // setup view
            cell.cellType = .detailedCell
            cell.hasRegularRightDetail = true
            cell.hasUpperTags = true
            cell.hasStyledTags = true
            cell.selectionStyle = .none
            
            // load content
            cell.contentImageView?.image = #imageLiteral(resourceName: "knight hacks image")
            for tag in tags {
                cell.addNewTag(tag: tag)
            }
            return cell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
}
