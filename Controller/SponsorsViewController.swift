//
//  SponsorsViewController.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 9/6/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

class SponsorsViewController: FilteredParentTableView {
    // Model has to be in the form [(String, [Int])]
    
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
            cell.cellType = .detailedCell
            cell.hasRegularRightDetail = true
            cell.hasUpperTags = true
            cell.contentImageView?.image = #imageLiteral(resourceName: "knight hacks image")
            cell.selectionStyle = .none
            return cell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
}
