//
//  LiveUpdatesTableViewController.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/22/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

internal class LiveUpdatesTableViewController: NavigationBarTableViewController, NavigationBarViewControllerExtension, ModelObserver {
    
    internal static let identifier: String = "LiveUpdatesTableViewController"
    
    private let liveCountDownViewHeight: CGFloat = 130
    
    private var liveCountDownView: LiveCountdownView!
    private var viewModel: LiveUpdateTableViewControllerModel!
    private var rocketRefreshControlView: RocketRefreshControlView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = LiveUpdateTableViewControllerModel()
        self.viewModel.observer = self
        
        self.initLiveCountDown()
        self.navigationItem.largeTitleDisplayMode = .never
        self.colorUpper(view: tableView, with: BACKGROUND_COLOR)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.attachRefreshControl()
        self.viewModel.fetchRecent()
        self.add(navigationController: navigationController, and: navigationItem, with: BACKGROUND_COLOR)
        
        self.liveCountDownView.targetEndDate = Date(timeIntervalSinceNow: 45) // dummy time
    }
    
    private func initLiveCountDown() {
        let frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: liveCountDownViewHeight)
        self.liveCountDownView = LiveCountdownView(frame: frame)
        self.tableView.tableHeaderView = liveCountDownView
    }
    
    // MARK: - Scroll view delegate
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.rocketRefreshControlView.startAnimation()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard viewModel != nil else {
            super.addBackgroundView(using: [])
            return 0
        }
        
        super.addBackgroundView(using: viewModel.viewContent)
        return viewModel.viewContent.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellType = viewModel.viewContent[indexPath.row]
        
        // Check if content recieved contains imageURL value. Depending on this value cell type will vary.
        if cellType.imageURL == nil {
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: LiveUpdatesTableViewCell.identifier, for: indexPath) as? LiveUpdatesTableViewCell,
                indexPath.row < viewModel.viewContent.count else {
                return UITableViewCell()
            }
            
            cell.model = viewModel.viewContent[indexPath.row]
            return cell
            
        } else {
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: LiveUpdatesLargeTableViewCell.identifier, for: indexPath) as? LiveUpdatesLargeTableViewCell,
                indexPath.row < viewModel.viewContent.count else {
                return UITableViewCell()
            }
            
            cell.model = viewModel.viewContent[indexPath.row]
            return cell
        }
    }
    
    // MARK: - View model delegate
    
    func didFetchModel() {
        tableView.reloadData()
    }
    
    // MARK: - Refresh Control
    
    private func attachRefreshControl() {
        let control = UIRefreshControl()
        control.tintColor = .clear
        control.backgroundColor = .clear
        control.addTarget(self, action: #selector(fetchNewUpdates), for: .valueChanged)
        
        self.tableView.addSubview(control)
        self.rocketRefreshControlView = RocketRefreshControlView(frame: CGRect.zero)
        self.rocketRefreshControlView.refreshControl = control
    }
    
    @objc private func fetchNewUpdates() {
        self.viewModel.fetchRecent()
    }
}
