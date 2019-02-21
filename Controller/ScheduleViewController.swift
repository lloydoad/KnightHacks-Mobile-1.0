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
    
    var orderedScheduleObjects: [ScheduleGroup] = []
    var allScheduleObjects: [ScheduleObject] = [] {
        didSet {
            filterScheduleObjects()
            super.reloadTableContent()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.childDelegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        orderedScheduleObjects = []
        
        super.reloadTableContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let currentDate = Date()
        var retrievedScheduleObjects: [ScheduleObject] = []
        
        super.viewWillAppear(animated)
        fetchData()
        
        RequestSingleton.getData(at: GET_SCHEDULE_URL, with: nil) { (responseArray) in
            guard let responseArray = responseArray else {
                if self.isViewLoaded && self.view.window != nil {
                    let errorCallBack = ErrorPopUpViewController(message: "Request Error")
                    errorCallBack.present()
                }
                return
            }
            
            responseArray.forEach {
                let singleScheduleObject = ScheduleObject(json: $0)
                if singleScheduleObject.endDateObject ?? Date() >= currentDate {
                    retrievedScheduleObjects.append(singleScheduleObject)
                }
            }
            
            retrievedScheduleObjects = retrievedScheduleObjects.sorted { (firstScheduleObj, secondScheduleObj) -> Bool in
                guard let firstDate = firstScheduleObj.startDateObject,
                    let secondDate = secondScheduleObj.startDateObject else {
                        return false
                }
                return firstDate.timeIntervalSince1970 < secondDate.timeIntervalSince1970
            }
            
            self.allScheduleObjects = retrievedScheduleObjects
        }
    }
    
    private func fetchData() {
        let currentDate = Date()
        var scheduleObjects: [ScheduleObject] = []
        
        RequestSingleton.getData(at: GET_SCHEDULE_URL, with: nil) { (responseArray) in
            guard let responseArray = responseArray else {
                if self.isViewLoaded && self.view.window != nil {
                    let errorCallBack = ErrorPopUpViewController(message: "Request Error")
                    errorCallBack.present()
                }
                return
            }
            
            responseArray.forEach {
                let scheduleObject = ScheduleObject(json: $0)
                if scheduleObject.endDateObject ?? Date() >= currentDate {
                    scheduleObjects.append(scheduleObject)
                }
            }
            
            scheduleObjects.sort(by: {
                return $0.startDateObject?.timeIntervalSince1970 ?? 0 < $1.startDateObject?.timeIntervalSince1970 ?? 1
            })
            
            self.allScheduleObjects = scheduleObjects
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section < orderedScheduleObjects.count && indexPath.row < orderedScheduleObjects[indexPath.section].objects.count {
            return makeCellFromModel(content: orderedScheduleObjects[indexPath.section].objects[indexPath.row], indexPath: indexPath)
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
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
        var content: [Int:[Int]] = [:]
        
        orderedScheduleObjects.enumerated().forEach {
            content[$0] = [Int].init(repeating: 1, count: $1.objects.count)
        }
        
        return content
    }
    
    func setTableViewHeaderTitles() -> [String] {
        return orderedScheduleObjects.map { $0.day }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filterScheduleObjects(by: filterButtons[indexPath.row].type)
        super.reloadTableContent()
    }
    
    private func filterScheduleObjects(by filter: Filter = Filter.all) {
        var headers: [String] = []
        var headerSchedulePair: [String:[ScheduleObject]] = [:]
        
        orderedScheduleObjects = []
        
        allScheduleObjects.forEach {
            if filter == .all || $0.eventType == filter.rawValue {
                if headerSchedulePair[$0.formattedHeader] != nil {
                    headerSchedulePair[$0.formattedHeader]?.append($0)
                } else {
                    headers.append($0.formattedHeader)
                    headerSchedulePair[$0.formattedHeader] = [$0]
                }
            }
        }
        
        orderedScheduleObjects = headers.map {
            if let group = headerSchedulePair[$0] {
                return ScheduleGroup(day: $0, objects: group)
            } else {
                return ScheduleGroup(day: "Header error", objects: [])
            }
        }
    }
    
    private func makeCellFromModel(content: ScheduleObject, indexPath: IndexPath) -> DynamicTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DynamicTableViewCell.identifier, for: indexPath) as! DynamicTableViewCell
        
        cell.cellType = .defaultCell
        cell.selectionStyle = .none
        cell.titleLabel?.text = content.title
        cell.locationLabel?.text = content.location
        cell.timeLabel?.text = content.formattedTime
        
        return cell
    }
}
