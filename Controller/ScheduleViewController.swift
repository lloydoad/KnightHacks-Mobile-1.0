//
//  ScheduleViewController.swift
//  KnightHacks
//
//  Created by KnightHacks on 9/1/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

class ScheduleViewController: FilteredParentTableView, FilteredParentTableViewDelegate {
    let GET_SCHEDULE_URL: String = RequestSingleton.BASE_URL + "/api/get_schedule"
    
    var allScheduleObjects: [ScheduleObject] = []
    var sortedScheduleObjects: [String: [ScheduleObject]] = [:]
    var sortedScheduleHeaders: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.childDelegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        super.reloadTableContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        RequestSingleton.getData(at: GET_SCHEDULE_URL, with: nil) { (responseArray) in
            guard let responseArray = responseArray else {
                return
            }
            
            for response in responseArray {
                let singleScheduleObject = ScheduleObject(json: response)
                self.allScheduleObjects.append(singleScheduleObject)
            }
            
            self.allScheduleObjects = self.allScheduleObjects.sorted { (objectOne, ObjectTwo) -> Bool in
                guard let dateOne = objectOne.startDateObject,
                    let dateTwo = ObjectTwo.startDateObject else {
                        return false
                }
                return dateOne.timeIntervalSince1970 < dateTwo.timeIntervalSince1970
            }
            
            self.filterScheduleObjects()
            super.reloadTableContent()
        }
    }
    
    func filterScheduleObjects(by filter: Filter = Filter.all) {
        sortedScheduleHeaders = []
        sortedScheduleObjects = [:]
        
        for item in allScheduleObjects {
            let dayOfWeek = StringDateFormatter.getFormattedTime(from: item.startDateObject!, with: .dayOfWeek)
            let monthDay = StringDateFormatter.getFormattedTime(from: item.startDateObject!, with: .monthAndDay)
            var formattedHeaderTitle = dayOfWeek ?? ""
            formattedHeaderTitle += ", \(monthDay ?? "")"
            
            if filter != .all && item.eventType != filter.rawValue {
                continue
            }
            
            if !sortedScheduleObjects.keys.contains(formattedHeaderTitle) {
                sortedScheduleObjects[formattedHeaderTitle] = []
                sortedScheduleHeaders.append(formattedHeaderTitle)
            }
            
            sortedScheduleObjects[formattedHeaderTitle]!.append(item)
        }
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
        var sectionIndex: Int = 0
        var sectionedContent: [Int: [ScheduleObject]] = [:]
        
        for eachDay in sortedScheduleObjects {
            sectionedContent[sectionIndex] = eachDay.value
            sectionIndex += 1
        }
        
        return sectionedContent
    }
    
    func setTableViewHeaderTitles() -> [String] {
        return sortedScheduleHeaders
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filterScheduleObjects(by: filterButtons[indexPath.row].type)
        super.reloadTableContent()
    }
    
    // override cells excluding filter menu cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DynamicTableViewCell.identifier, for: indexPath) as! DynamicTableViewCell
            let content = sortedScheduleObjects[sortedScheduleHeaders[indexPath.section - 1]]![indexPath.row]
            
            cell.cellType = .defaultCell
            cell.selectionStyle = .none
            cell.titleLabel?.text = content.title
            cell.locationLabel?.text = content.location
            cell.timeLabel?.text = content.formattedTime
            
            return cell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
}
