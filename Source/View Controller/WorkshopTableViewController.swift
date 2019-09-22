//
//  WorkshopTableViewController.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 6/27/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

internal class WorkshopTableViewController: NavigationBarTableViewController, NavigationBarViewControllerExtension, FilterCollectionViewObserver, ModelObserver {
    
    internal static let identifier: String = "WorkshopTableViewController"
    
    private var filterCollectionView: FilterCollectionView!
    private var viewModel: WorkshopTableViewControllerModel!

    var filters: [FilterMenuModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = WorkshopTableViewControllerModel()
        self.filters = viewModel.filters
        self.viewModel.observer = self
        
        self.navigationItem.largeTitleDisplayMode = .never
        self.colorUpper(view: tableView, with: BACKGROUND_COLOR)
        self.filterCollectionView = addFilterCollectionView(to: tableView, datasource: self.viewModel)
        self.viewModel.filterCollectionView = self.filterCollectionView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.fetchWorkshopData()
        self.add(navigationController: navigationController, and: navigationItem, with: BACKGROUND_COLOR)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        filterCollectionView.shouldStartLoadingAnimation = true
    }
    
    // MARK: - Filter Delegate
    
    func didSelectFilter(filter: FilterMenuModel) {
        viewModel.filterData(filter)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        super.addBackgroundView(using: viewModel.viewContent)
        return viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = FilterTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
        
        if section < viewModel.viewContent.count {
            view.headerLabel.text = viewModel.viewContent[section].first?.header
        }
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(HEADER_IN_SECTION_HEIGHT)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.viewContent[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: WorkshopTableViewCell.identifier, for: indexPath) as? WorkshopTableViewCell,
            indexPath.section < viewModel.viewContent.count,
            indexPath.row < viewModel.viewContent[indexPath.section].count else {
            return UITableViewCell()
        }
        
        cell.model = viewModel.viewContent[indexPath.section][indexPath.row]
        return cell
    }
    
    // MARK: - View model delegate
    
    func didFetchModel() {
        tableView.reloadData()
    }
}
