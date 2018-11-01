//
//  LiveUpdateTableViewController.swift
//  KnightHacks
//
//  Created by KnightHacks on 9/17/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

class LiveUpdatesViewController: ParentTableView {
    let GET_FAQS_URL: String = RequestSingleton.BASE_URL + "/api/get_live_updates"
    let GET_RECENT_FAQS_URL: String = RequestSingleton.BASE_URL + "/api/get_live_updates_recent"
    let DATE_PARAMETER_KEY: String = "date"
    
    var refreshControlView: UIRefreshControl?
    var lastFetchDate: Date?
    var liveUpdateContent: [LiveUpdateObject] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.register(LiveUpdatesTableViewCell.self, forCellReuseIdentifier: LiveUpdatesTableViewCell.identifier)
        getNewContent()
        attachRefreshControl()
    }
    
    func attachRefreshControl() {
        refreshControlView = UIRefreshControl()
        self.tableView.addSubview(refreshControlView!)
        refreshControlView?.addTarget(self, action: #selector(getNewContent), for: .valueChanged)
    }
    
    @objc func getNewContent() {
        var fetchUrl: String = ""
        var parameter: [String:String]?
        
        let formatter = StringDateFormatter()
        if let lastFetchDate = lastFetchDate {
            let DATE_PARAMETER_VALUE = formatter.convertZuluDateToString(dateObject: lastFetchDate)
            parameter = [DATE_PARAMETER_KEY:DATE_PARAMETER_VALUE]
        }
        if parameter == nil {
            fetchUrl = GET_FAQS_URL
        } else {
            fetchUrl = GET_RECENT_FAQS_URL
        }
        
        RequestSingleton.getData(at: fetchUrl, with: parameter) { (responseArray) in
            guard let responseArray = responseArray else {
                if parameter == nil && self.isViewLoaded && self.view.window != nil {
                    let errorCallBack = ErrorPopUpViewController(message: "Oops! Something went wrong")
                    errorCallBack.present()
                    self.lastFetchDate = nil
                }
                self.refreshControlView?.endRefreshing()
                return
            }
            
            for response in responseArray {
                let singleContentObject = LiveUpdateObject(json: response)
                self.lastFetchDate = singleContentObject.dateObject?.addingTimeInterval(1)
                self.liveUpdateContent.insert(singleContentObject, at: 0)
            }
            self.refreshControlView?.endRefreshing()
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
            cellContentItem.imageContainer = cell.contentImageView!
            cell.contentImageView?.image = cellContentItem.imageContainer.image
            cell.itemDescriptionLabel?.text = cellContentItem.description
            cell.timeLabel?.text = cellContentItem.formattedTime
            cell.selectionStyle = .none
            
            return cell
        }
    }
}
