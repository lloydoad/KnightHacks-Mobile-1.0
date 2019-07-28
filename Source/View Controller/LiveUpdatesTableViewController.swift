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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLiveCountDown()
        
        viewModel = LiveUpdateTableViewControllerModel()
        viewModel.observer = self
        
        self.navigationItem.largeTitleDisplayMode = .never
        self.colorUpper(view: tableView, with: BACKGROUND_COLOR)
    }
    
    private func initLiveCountDown() {
        let frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: liveCountDownViewHeight)
        liveCountDownView = LiveCountdownView(frame: frame)
        tableView.tableHeaderView = liveCountDownView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.add(navigationController: navigationController, and: navigationItem, with: BACKGROUND_COLOR)
        
        /* dummy time */
        let date = Date(timeIntervalSinceNow: 45)
        liveCountDownView.targetEndDate = date
        
        viewModel.fetchRecent()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard viewModel != nil else { return 0 }
        return viewModel.viewContent.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: LiveUpdatesTableViewCell.identifier, for: indexPath) as? LiveUpdatesTableViewCell,
            indexPath.row < viewModel.viewContent.count else {
            return UITableViewCell()
        }
        
        cell.model = viewModel.viewContent[indexPath.row]
        return cell
    }
    
    func didFetchModel() {
        tableView.reloadData()
    }

}
