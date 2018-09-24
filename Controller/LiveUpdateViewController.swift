//
//  LiveUpdateTableViewController.swift
//  KnightHacks
//
//  Created by KnightHacks on 9/17/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

class LiveUpdatesViewController: ParentTableView {
    var liveUpdateContent: [LiveUpdateObject] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.register(LiveUpdatesTableViewCell.self, forCellReuseIdentifier: LiveUpdatesTableViewCell.identifier)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return LIVE_UPDATE_VIEW_HEIGHT
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
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
            cell.cellType = .leftImageCell
            cell.contentImageView?.image = #imageLiteral(resourceName: "knight hacks image")
            cell.selectionStyle = .none
            return cell
        }
    }
}
