//
//  WorkshopsViewController.swift
//  KnightHacks
//
//  Created by KnightHacks on 9/6/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

class WorkshopsViewController: FilteredParentTableView, FilteredParentTableViewDelegate {
    let tags: [String] = ["default 1", "default 2"]
    let GET_WORKSHOP_UPDATE: String = RequestSingleton.BASE_URL + "/api/get_workshops"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.childDelegate = self
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
        return [
            "Friday",
            "Saturday",
            "Sunday"
        ]
    }
    
    // override cells excluding filter menu cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DynamicTableViewCell.identifier, for: indexPath) as! DynamicTableViewCell
            cell.cellType = .detailedCell
            parseImage(at:"https://backgroundcheckall.com/wp-content/uploads/2017/12/san-francisco-background.jpg", into: cell.contentImageView!, completion: nil)
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
