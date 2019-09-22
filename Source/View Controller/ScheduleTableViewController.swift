//
//  ScheduleTableViewController.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 6/23/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

internal class ScheduleTableViewController: NavigationBarViewController, NavigationBarViewControllerExtension, FilterCollectionViewObserver, ModelObserver {
    
    internal static let identifier: String = "ScheduleTableViewController"

    @IBOutlet private weak var mainTableView: UITableView!
    
    private var filterCollectionView: FilterCollectionView!
    private var viewModel: ScheduleTableViewControllerModel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.viewModel = ScheduleTableViewControllerModel()
        self.viewModel.observer = self
        
        self.colorUpper(view: mainTableView, with: BACKGROUND_COLOR)
        self.filterCollectionView = addFilterCollectionView(to: mainTableView, datasource: viewModel)
        self.viewModel.filterCollectionView = self.filterCollectionView
        
        self.attach(table: mainTableView, toDelegate: self, andDataSource: self)
        self.add(navigationController: navigationController, and: navigationItem, with: BACKGROUND_COLOR)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.fetchScheduleData()
    }
    
    // MARK: - Filter Delegate
    
    func didSelectFilter(filter: FilterMenuModel) {
        viewModel.filterData(filter)
    }

    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        super.addBackgroundView(to: mainTableView, using: viewModel.viewContent)
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = FilterTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
        
        if section < viewModel.viewContent.count {
            view.headerLabel.text = viewModel.viewContent[section].first?.header
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(HEADER_IN_SECTION_HEIGHT)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.viewContent[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.identifier, for: indexPath) as? ScheduleTableViewCell,
            indexPath.section < viewModel.viewContent.count,
            indexPath.row < viewModel.viewContent[indexPath.section].count else {
            return UITableViewCell()
        }
        
        cell.model = viewModel.viewContent[indexPath.section][indexPath.row]
        return cell
    }
    
    // MARK: - View model delegate
    
    func didFetchModel() {
        mainTableView.reloadData()
    }
}
