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
    
    var customRefreshControl: UIRefreshControl!
    var customRefreshControlView: UIView!
    var roverToScreenTrailingAnchor: NSLayoutConstraint!
    var roverImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        setupRefreshControl()
        
        for _ in 1...3 {
            liveUpdateContent.append(addNewLiveObject())
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.register(LiveUpdatesTableViewCell.self, forCellReuseIdentifier: LiveUpdatesTableViewCell.identifier)
    }

    func setupRefreshControl() {
        customRefreshControl = UIRefreshControl()
        customRefreshControl.tintColor = .clear
        customRefreshControl.backgroundColor = .clear
        customRefreshControl.addTarget(self, action: #selector(updateTableContent), for: .valueChanged)
        tableView.addSubview(customRefreshControl)
        
        customRefreshControlView = UIView();
        customRefreshControlView.backgroundColor = BACKGROUND_COLOR
        customRefreshControlView.translatesAutoresizingMaskIntoConstraints = false
        boundEdges(of: customRefreshControlView, to: customRefreshControl, with: UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0))
        
        roverImageView = UIImageView()
        roverImageView.image = UIImage(named: "rover")
        roverImageView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        roverImageView.contentMode = .scaleAspectFit
        roverImageView.translatesAutoresizingMaskIntoConstraints = false
        customRefreshControlView.addSubview(roverImageView)
        roverImageView.topAnchor.constraint(equalTo: customRefreshControlView.topAnchor, constant: 0).isActive = true
        roverImageView.bottomAnchor.constraint(equalTo: customRefreshControlView.bottomAnchor, constant: 0).isActive = true
        roverImageView.leadingAnchor.constraint(equalTo: customRefreshControlView.leadingAnchor, constant: 15).isActive = true
        roverToScreenTrailingAnchor = roverImageView.trailingAnchor.constraint(equalTo: customRefreshControlView.trailingAnchor, constant: -240)
        roverToScreenTrailingAnchor.isActive = true
    }
    
    @objc func updateTableContent() {
        liveUpdateContent.append(addNewLiveObject())
        // fetch content and move animation to fetch closure
        
        animateRoverInRefreshView()
    }
    
    func animateRoverInRefreshView() {
        if(customRefreshControl.isRefreshing) {
            let scaleTransform = CGAffineTransform(scaleX: 1.03, y: 1.03)
            
            UIView.animate(withDuration: 0.5, delay: 1, options: .autoreverse, animations: {
                self.roverImageView.transform = scaleTransform
            }, completion: { (_) in
                UIView.animate(withDuration: 1.02, delay: 0.1, options: .curveEaseIn, animations: {
                    self.roverToScreenTrailingAnchor.constant = UIScreen.main.bounds.width + 80
                    self.customRefreshControlView.layoutIfNeeded()
                }) { (_) in
                    self.customRefreshControl.endRefreshing()
                    self.tableView.reloadData()
                    
                    UIView.animate(withDuration: 0, delay: 0.3, options: .curveEaseOut, animations: {
                        self.roverToScreenTrailingAnchor.constant = -240
                        self.customRefreshControlView.layoutIfNeeded()
                    }, completion: nil)
                }
            })
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
            let cellContent = liveUpdateContent[indexPath.row - 1]
            cell.cellType = .leftImageCell
            
            cell.contentImageView?.image = cellContent.image
            cell.itemDescriptionLabel?.text = cellContent.description
            cell.timeLabel?.text = cellContent.time
            cell.selectionStyle = .none
            return cell
        }
    }
    
    // MARK: - TEMP FUNCTION
    func addNewLiveObject() -> LiveUpdateObject{
        return LiveUpdateObject(description: "Lorem ipsum dolor sit. Lorem ipsum dolor sit.", time: "9:15pm", timeSince: 29 * 60, image: UIImage(named: "knight hacks image")!)
    }
}
