//
//  ScheduleViewController.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 9/1/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

class ScheduleViewController: FilteredParentTableView, FilteredParentTableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.childDelegate = self
    }
    
    func setFilterMenuCellContents() -> [FilterButton] {
        return [
            FilterButton(input: Filter.NOT_SET),
            FilterButton(input: Filter.talks),
            FilterButton(input: Filter.workshops),
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
    
    // Override cells excluding filter menu cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DynamicTableViewCell.identifier, for: indexPath) as! DynamicTableViewCell
            cell.cellType = .defaultCell
            cell.selectionStyle = .none
            return cell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
}
