//
//  WorkshopsViewController.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 9/6/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

class WorkshopsViewController: FilteredParentTableView {
    // Model has to be in the form [(String, [Int])]
    
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
            cell.selectionStyle = .none
            return cell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
}
