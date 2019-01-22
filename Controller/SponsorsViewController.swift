//
//  SponsorsViewController.swift
//  KnightHacks
//
//  Created by KnightHacks on 9/6/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

class SponsorsViewController: FilteredParentTableView, FilteredParentTableViewDelegate {
    let GET_SPONSORS_UPDATE: String = RequestSingleton.BASE_URL + "/api/get_sponsors"
    let maximumTagCount: Int = 3
    
    var filteredSponsorsObjects: [SponsorsObject] = []
    var allSponsorsObjects: [SponsorsObject] = [] {
        didSet {
            self.filteredSponsorsObjects = allSponsorsObjects
            super.reloadTableContent()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.childDelegate = self
        
        hasHeaders = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        allSponsorsObjects = []
        super.reloadTableContent()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return indexPath.row < filteredSponsorsObjects.count ?
            makeCellModel(content: filteredSponsorsObjects[indexPath.row], indexPath: indexPath) :
            super.tableView(tableView, cellForRowAt: indexPath)
    }
    
    private func makeCellModel(content: SponsorsObject, indexPath: IndexPath) -> DynamicTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DynamicTableViewCell.identifier, for: indexPath) as! DynamicTableViewCell
        cell.cellType = .detailedCell
        cell.isTimeStampMinimized = true
        cell.hasUpperTags = true
        cell.hasStyledTags = true
        cell.selectionStyle = .none
        
        cell.titleLabel?.text = content.name
        cell.itemDescriptionLabel?.text = content.description
        cell.timeLabel?.text = content.location
        parseImage(at: content.imageUrl, into: cell.contentImageView!, completion: nil)
        content.offerings.enumerated().forEach {
            if $0 < maximumTagCount {
                cell.addNewTag(tag: $1)
            }
        }
        
        return cell
    }
    
    private func fetchData() {
        RequestSingleton.getData(at: GET_SPONSORS_UPDATE, with: nil) { (responseArray) in
            guard let responseArray = responseArray else {
                if self.isViewLoaded && self.view.window != nil {
                    let errorCallBack = ErrorPopUpViewController(message: "Request Error")
                    errorCallBack.present()
                }
                return
            }
            
            self.allSponsorsObjects = responseArray.map(SponsorsObject.init)
        }
    }
    
    private func filterContent(by filter: Filter = Filter.all) {
        filteredSponsorsObjects = []
        
        allSponsorsObjects.forEach {
            if filter == .all || $0.filters.contains(filter) {
                filteredSponsorsObjects.append($0)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filterContent(by: filterButtons[indexPath.row].type)
        super.reloadTableContent(withFilter: false)
    }
    
    func setFilterMenuCellContents() -> [FilterButton] {
        return [
            FilterButton(input: Filter.local),
            FilterButton(input: Filter.internships),
            FilterButton(input: Filter.full_time),
            FilterButton(input: Filter.all)
        ]
    }
    
    func setTableViewCellContents() -> [Int : [Any]] {
        return filteredSponsorsObjects.isEmpty ? [:] : [0:[Int].init(repeating: 1, count: filteredSponsorsObjects.count)]
    }
    
    func setTableViewHeaderTitles() -> [String] {
        return []
    }
}
