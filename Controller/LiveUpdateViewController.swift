//
//  LiveUpdateTableViewController.swift
//  KnightHacks
//
//  Created by KnightHacks on 9/17/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

class LiveUpdatesViewController: ParentTableView {
    let GET_LIVE_UPDATE_URL: String = RequestSingleton.BASE_URL + "/api/get_live_updates"
    let GET_RECENT_LIVE_UPDATES_URL: String = RequestSingleton.BASE_URL + "/api/get_live_updates_recent"
    
    let imageLength: CGFloat = 50.0
    let startXOffset: CGFloat = -30
    let endXOffset: CGFloat = 420
    
    var liveUpdateCountdownTimer: LiveUpdateCountdownTimerViewController?
    var refreshControlView: UIRefreshControl?
    var customRefreshControlView: UIView!
    var rocketImageView: UIImageView!
    var rocketImageXAnchor: NSLayoutConstraint!
    var isAnimating: Bool = false
    
    var lastFetchDate: Date?
    var liveUpdateObjects: [LiveUpdateObject] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.liveUpdateCountdownTimer = LiveUpdateCountdownTimerViewController(frame:
            CGRect(x: 0, y: 0, width: self.view.frame.width, height: LIVE_UPDATE_VIEW_HEIGHT)
        )
        self.liveUpdateCountdownTimer?.backgroundColor = BACKGROUND_COLOR
        self.tableView.tableHeaderView = liveUpdateCountdownTimer
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getNewLiveUpdates()
        self.attachRefreshControl()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.liveUpdateObjects = []
        self.lastFetchDate = nil
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.estimatedRowHeight
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liveUpdateObjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return makeCellModelFrom(content: liveUpdateObjects[indexPath.row], indexPath: indexPath)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refreshControlView?.isRefreshing ?? false {
            if !isAnimating {
                startRocketAnimation()
            }
        }
    }
    
    @objc private func getNewLiveUpdates() {
        var fetchUrl: String = ""
        var parameter: [String:String]?
        
        if let lastFetchDate = lastFetchDate {
            let DATE_PARAMETER_VALUE = StringDateFormatter.convertZuluDateToString(dateObject: lastFetchDate)
            parameter = [LiveUpdateObject.API_DATE_PARAMETER_KEY:DATE_PARAMETER_VALUE]
            fetchUrl = GET_RECENT_LIVE_UPDATES_URL
        } else {
            fetchUrl = GET_LIVE_UPDATE_URL
        }
        
        RequestSingleton.getData(at: fetchUrl, with: parameter) { (responseArray) in
            guard let responseArray = responseArray else {
                if self.isViewLoaded && self.view.window != nil {
                    ErrorPopUpViewController(message: "Request Error").present()
                }
                
                self.refreshControlView?.endRefreshing()
                return
            }
            
            for response in responseArray {
                let parsedLiveUpdateObject = LiveUpdateObject(json: response)
                self.lastFetchDate = parsedLiveUpdateObject.dateObject?.addingTimeInterval(1)
                self.liveUpdateObjects.insert(parsedLiveUpdateObject, at: 0)
            }
        }
    }
    
    private func startRocketAnimation() {
        self.isAnimating = true
        
        if self.refreshControlView?.isRefreshing ?? false {
            self.rocketImageView.alpha = 1
            
            let timingFunction = CAMediaTimingFunction(controlPoints: 4.6/6.0, 0.25, 4/6.0, 1)
            
            CATransaction.begin()
            CATransaction.setAnimationTimingFunction(timingFunction)
            
            UIView.animate(withDuration: 2.0, animations: {
                self.rocketImageXAnchor.constant = self.endXOffset
                self.refreshControlView?.layoutIfNeeded()
            }) { (_) in
                self.refreshControlView?.endRefreshing()
                self.rocketImageXAnchor.constant = self.startXOffset
                self.rocketImageView.alpha = 0
                self.isAnimating = false
            }
            
            CATransaction.commit()
        }
    }

    private func attachRefreshControl() {
        self.refreshControlView = UIRefreshControl()
        self.refreshControlView?.tintColor = .clear
        self.refreshControlView?.backgroundColor = .clear
        self.tableView.addSubview(refreshControlView!)
        self.refreshControlView?.addTarget(self, action: #selector(getNewLiveUpdates), for: .valueChanged)
        
        self.customRefreshControlView = UIView();
        self.customRefreshControlView.translatesAutoresizingMaskIntoConstraints = false
        boundEdges(of: customRefreshControlView, to: refreshControlView!, with: UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0))
        
        self.rocketImageView = UIImageView()
        self.rocketImageView.image = UIImage(named: "rocket-5")
        self.rocketImageView.transform = CGAffineTransform(rotationAngle: (.pi/2))
        self.rocketImageView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.rocketImageView.contentMode = .scaleAspectFit
        self.rocketImageView.alpha = 0
        
        self.rocketImageView.translatesAutoresizingMaskIntoConstraints = false
        self.customRefreshControlView.addSubview(rocketImageView)
        self.rocketImageView.heightAnchor.constraint(equalToConstant: imageLength).isActive = true
        self.rocketImageView.widthAnchor.constraint(equalToConstant: imageLength).isActive = true
        self.rocketImageView.centerYAnchor.constraint(equalTo: customRefreshControlView.centerYAnchor).isActive = true
        
        self.rocketImageXAnchor = rocketImageView.leftAnchor.constraint(equalTo: customRefreshControlView.leftAnchor, constant: startXOffset)
        self.rocketImageXAnchor.isActive = true
    }
    
    private func makeCellModelFrom(content: LiveUpdateObject, indexPath: IndexPath) -> DynamicTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DynamicTableViewCell.identifier, for: indexPath) as! DynamicTableViewCell
        
        cell.cellType = .leftImageCell
        parseImage(at: content.imageUrl, into: cell.contentImageView ?? UIImageView(), completion: nil)
        cell.itemDescriptionLabel?.text = content.description
        cell.timeLabel?.text = content.formattedTime
        cell.selectionStyle = .none
        
        return cell
    }
}
