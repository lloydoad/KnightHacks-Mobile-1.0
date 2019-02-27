//
//  WorkshopsViewController.swift
//  KnightHacks
//
//  Created by KnightHacks on 9/6/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

class WorkshopsViewController: FilteredParentTableView, FilteredParentTableViewDelegate {
    let GET_WORKSHOPS_UPDATE: String = RequestSingleton.BASE_URL + "/api/get_workshops"
    
    var orderedWorkshopObjects: [WorkshopsGroup] = []
    var allWorkshopObjects: [WorkshopsObject] = [] {
        didSet {
            filterContent()
            super.reloadTableContent()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.childDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        orderedWorkshopObjects = []
        super.reloadTableContent()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section < orderedWorkshopObjects.count && indexPath.row < orderedWorkshopObjects[indexPath.section].objects.count {
            return makeCellModel(content: orderedWorkshopObjects[indexPath.section].objects[indexPath.row], indexPath: indexPath)
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    private func makeCellModel(content: WorkshopsObject, indexPath: IndexPath) -> DynamicTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DynamicTableViewCell.identifier, for: indexPath) as! DynamicTableViewCell
        cell.cellType = .detailedCell
        cell.selectionStyle = .none
        
        cell.titleLabel?.text = content.name
        cell.timeLabel?.text = content.formattedTime
        cell.itemDescriptionLabel?.text = content.description
        parseImage(at: content.imageUrl, into: cell.contentImageView!, completion: nil)
        for (index, tag) in content.tags.enumerated() {
            if index < 4 {
                cell.addNewTag(tag: tag)
            }
        }
        
        return cell
    }
    
    private func fetchData() {
        let currentDate = Date()
        var workshopsObjects: [WorkshopsObject] = []

        RequestSingleton.getData(at: GET_WORKSHOPS_UPDATE, with: nil) { (responseArray) in
            guard let responseArray = responseArray else {
                if self.isViewLoaded && self.view.window != nil {
                    let errorCallBack = ErrorPopUpViewController(message: "Request Error")
                    errorCallBack.present()
                }
                return
            }
            
            responseArray.forEach {
                let workshop = WorkshopsObject(json: $0)
                if workshop.endDateObject ?? Date() >= currentDate {
                    workshopsObjects.append(workshop)
                }
            }
            
            workshopsObjects.sort(by: {
                return $0.startDateObject?.timeIntervalSince1970 ?? 0 <
                    $1.startDateObject?.timeIntervalSince1970 ?? 1
            })
            
            self.allWorkshopObjects = workshopsObjects
        }
    }
    
    private func filterContent(by filter: Filter = Filter.all) {
        var headers: [String] = []
        var headerWorkshopPair: [String:[WorkshopsObject]] = [:]
        
        orderedWorkshopObjects = []
        
        allWorkshopObjects.forEach {
            if filter == .all || $0.tags.contains(filter.rawValue) {
                if headerWorkshopPair[$0.formattedHeader] != nil {
                    headerWorkshopPair[$0.formattedHeader]?.append($0)
                } else {
                    headers.append($0.formattedHeader)
                    headerWorkshopPair[$0.formattedHeader] = [$0]
                }
            }
        }
        
        orderedWorkshopObjects = headers.map {
            if let group = headerWorkshopPair[$0] {
                return WorkshopsGroup(day: $0, objects: group)
            } else {
                return WorkshopsGroup(day: "Header error", objects: [])
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filterContent(by: filterButtons[indexPath.row].type)
        super.reloadTableContent(withFilter: false)
    }
    
    func setFilterMenuCellContents() -> [FilterButton] {
        return [
            FilterButton(input: Filter.hardware),
            FilterButton(input: Filter.beginner),
            FilterButton(input: Filter.advanced),
            FilterButton(input: Filter.career),
            FilterButton(input: Filter.design),
            FilterButton(input: Filter.development),
            FilterButton(input: Filter.all)
        ]
    }
    
    func setTableViewCellContents() -> [Int : [Any]] {
        var content: [Int:[Int]] = [:]
        
        orderedWorkshopObjects.enumerated().forEach {
            content[$0] = [Int].init(repeating: 1, count: $1.objects.count)
        }
        
        return content
    }
    
    func setTableViewHeaderTitles() -> [String] {
        return orderedWorkshopObjects.map { $0.day }
    }
}
