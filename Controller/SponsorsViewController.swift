//
//  SponsorsViewController.swift
//  KnightHacks
//
//  Created by KnightHacks on 9/6/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

class SponsorsViewController: FilteredParentTableView, FilteredParentTableViewDelegate {
    // temp array to represent loaded tags
    let tags: [String] = ["default 1", "default 2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.childDelegate = self
        
        hasHeaders = false
    }
    
    // protocol functions
    func setFilterMenuCellContents() -> [FilterButton] {
        return [
            FilterButton(input: Filter.NOT_SET),
            FilterButton(input: Filter.internships),
            FilterButton(input: Filter.full_time),
            FilterButton(input: Filter.all)
        ]
    }
    func setTableViewCellContents() -> [Int : [Any]] {
        return [
            0:[1,1,1],
            1:[1,1],
            2:[1,1,1,1]
        ]
    }
    func setTableViewHeaderTitles() -> [String] {
        return []
    }
    
    // override cells excluding filter menu cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DynamicTableViewCell.identifier, for: indexPath) as! DynamicTableViewCell
            // setup view
            cell.cellType = .detailedCell
            cell.isTimeStampMinimized = true
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
