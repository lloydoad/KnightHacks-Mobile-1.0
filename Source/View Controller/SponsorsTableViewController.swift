//
//  SponsorsTableViewController.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/28/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

internal class SponsorsTableViewController: NavigationBarTableViewController, NavigationBarViewControllerExtension, FilterCollectionViewExtension, ModelObserver {
    
    internal static let identifier: String = "SponsorsTableViewController"
    
    private var filterCollectionView: FilterCollectionView!
    private var viewModel: SponsorTableViewControllerModel!
    
    var filters: [FilterMenuModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = SponsorTableViewControllerModel()
        self.viewModel.observer = self
        self.filters = viewModel.filters
        
        self.navigationItem.largeTitleDisplayMode = .never
        self.filterCollectionView = addFilterCollectionView(to: tableView)
        self.colorUpper(view: tableView, with: BACKGROUND_COLOR)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.fetchSponsorData()
        self.add(navigationController: navigationController, and: navigationItem, with: BACKGROUND_COLOR)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.filterCollectionView.shouldStartLoadingAnimation = true
    }
    
    func didSelectFilter(filter: FilterMenuModel) {
        guard let type = filter.type else { return }
        self.viewModel.filterSponsorData(with: type)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.viewContent.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: SponsorsTableViewCell.identifier, for: indexPath) as? SponsorsTableViewCell,
            indexPath.row < viewModel.viewContent.count else {
            return UITableViewCell()
        }
        
        cell.model = viewModel.viewContent[indexPath.row]
        return cell
    }
    
    func didFetchModel() {
        self.tableView.reloadData()
    }
}
