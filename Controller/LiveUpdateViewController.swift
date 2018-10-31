//
//  LiveUpdateTableViewController.swift
//  KnightHacks
//
//  Created by KnightHacks on 9/17/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

class LiveUpdatesViewController: ParentTableView {
    var liveUpdateContent: [LiveUpdateObject] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var objectDatabaseURL: String = RequestSingleton.BASE_URL + "/api/get_live_updates"

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.register(LiveUpdatesTableViewCell.self, forCellReuseIdentifier: LiveUpdatesTableViewCell.identifier)
        
        // get objects
        RequestSingleton.getData(at: objectDatabaseURL, with: nil) { (responseArray) in
            guard let responseArray = responseArray else {
                // call to action
                return
            }
            
            for response in responseArray {
                let singleContentObject = LiveUpdateObject(json: response)
                self.liveUpdateContent.insert(singleContentObject, at: 0)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return LIVE_UPDATE_VIEW_HEIGHT
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liveUpdateContent.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LiveUpdatesTableViewCell.identifier, for: indexPath) as! LiveUpdatesTableViewCell
            
            if cell.liveUpdatesView == nil {
                cell.liveUpdatesView = LiveUpdateCountdownTimerViewController(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: LIVE_UPDATE_VIEW_HEIGHT))
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DynamicTableViewCell.identifier, for: indexPath) as! DynamicTableViewCell
            let cellContentItem = liveUpdateContent[indexPath.row - 1]
            
            cell.cellType = .leftImageCell
            // bind item image container to cell image container
            cellContentItem.imageContainer = cell.contentImageView!
            
            // change details
            cell.contentImageView?.image = cellContentItem.imageContainer.image
            cell.itemDescriptionLabel?.text = cellContentItem.description
            cell.timeLabel?.text = cellContentItem.formattedTime
            cell.selectionStyle = .none
            return cell
        }
    }
}
