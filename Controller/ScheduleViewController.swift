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
    
    var orderedScheduleHeaders: [String:Int] = [:]
    var orderedScheduleObjects: [Int:[ScheduleObject]] = [:]
    
    var allFetchedScheduleObjects: [ScheduleObject] = [] {
        didSet {
            filterScheduleObjects()
        }
    }
    let defaultScheduleObject: ScheduleObject = ScheduleObject(
        title: "Title", eventType: Filter.activity.rawValue, location: "Location",
        startTime: "2018-10-29T22:02:42.000Z", endTime: "2018-10-29T23:02:42.000Z"
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.childDelegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        allFetchedScheduleObjects = []
        orderedScheduleHeaders = [:]
        orderedScheduleObjects = [:]
        
        super.reloadTableContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var retrievedScheduleObjects: [ScheduleObject] = []
        
        super.viewWillAppear(animated)
        
        RequestSingleton.getData(at: GET_SCHEDULE_URL, with: nil) { (responseArray) in
            guard let responseArray = responseArray else {
                if self.isViewLoaded && self.view.window != nil {
                    let errorCallBack = ErrorPopUpViewController(message: "Request Error")
                    errorCallBack.present()
                }
                return
            }
            
            for response in responseArray {
                let singleScheduleObject = ScheduleObject(json: response)
                retrievedScheduleObjects.append(singleScheduleObject)
            }
            
            retrievedScheduleObjects = retrievedScheduleObjects.sorted { (firstScheduleObj, secondScheduleObj) -> Bool in
                guard let firstDate = firstScheduleObj.startDateObject,
                    let secondDate = secondScheduleObj.startDateObject else {
                        return false
                }
                return firstDate.timeIntervalSince1970 < secondDate.timeIntervalSince1970
            }
            
            self.allFetchedScheduleObjects = retrievedScheduleObjects
        }
    }
    
    func filterScheduleObjects(by filter: Filter = Filter.all) {
        var index: Int = 0
        orderedScheduleHeaders = [:]
        orderedScheduleObjects = [:]
        
        for item in allFetchedScheduleObjects {
            var formattedHeaderTitle: String = ""
            
            if filter != .all && item.eventType != filter.rawValue {
                continue
            }
            
            formattedHeaderTitle += StringDateFormatter.getFormattedTime(from: item.startDateObject!, with: .dayOfWeek) ?? ""
            formattedHeaderTitle += ", \(StringDateFormatter.getFormattedTime(from: item.startDateObject!, with: .monthAndDay) ?? "")"
            
            if !orderedScheduleHeaders.keys.contains(formattedHeaderTitle) {
                orderedScheduleHeaders[formattedHeaderTitle] = index
                orderedScheduleObjects[index] = []
                index += 1
            }
            
            if let headerTitleIndex = orderedScheduleHeaders[formattedHeaderTitle],
                let _ = orderedScheduleObjects[headerTitleIndex] {
                orderedScheduleObjects[headerTitleIndex]!.append(item)
            }
        }
        
        super.reloadTableContent()
    }
    
    func setFilterMenuCellContents() -> [FilterButton] {
        return [
            FilterButton(input: Filter.activity),
            FilterButton(input: Filter.food),
            FilterButton(input: Filter.talks),
            FilterButton(input: Filter.workshops),
            FilterButton(input: Filter.main_event),
            FilterButton(input: Filter.all)
        ]
    }
    
    func setTableViewCellContents() -> [Int : [Any]] {
        return orderedScheduleObjects
    }
    
    func setTableViewHeaderTitles() -> [String] {
        var headers: [String] = []
        
        for index in 0...orderedScheduleHeaders.count {
            headers.append(orderedScheduleHeaders.key(forValue: index) ?? "Header Error")
        }
        
        return headers
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filterScheduleObjects(by: filterButtons[indexPath.row].type)
        super.reloadTableContent()
    }
    
    // override cells excluding filter menu cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section > 0 {
            var content: ScheduleObject
            let cell = tableView.dequeueReusableCell(withIdentifier: DynamicTableViewCell.identifier, for: indexPath) as! DynamicTableViewCell
            
            if let contentSection = orderedScheduleObjects[indexPath.section - 1] {
                content = contentSection[indexPath.row]
            } else {
                content = defaultScheduleObject
            }
            
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
