//
//  HomeTableTableViewController.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 6/23/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

internal class HomeTableViewController: UITableViewController, NavigationBarViewControllerExtension {
    
    var viewModel: HomeTableViewControllerModel = HomeTableViewControllerModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.add(navigationController: navigationController, and: navigationItem, with: .white, tint: .white)
        self.updateNavigationTitle()
    }
    
    func updateNavigationTitle() {
        
        if #available(iOS 11, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: CELL_HEADER_FONT
            ]
        }
        
        self.navigationController?.view.backgroundColor = .white
    }
    
    // MARK: - Table view datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(viewModel.heightForRow)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier, for: indexPath) as? MenuTableViewCell,
            indexPath.row >= 0 && indexPath.row < self.viewModel.menuItems.count else {
            fatalError("Internal Error: Failed To Dequeue Cell")
        }
        
        cell.model = viewModel.menuItems[indexPath.row]
        return cell
    }
    
    // MARK: - Table view function
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let storyboardID = viewModel.menuItems[indexPath.row].connectedViewControllerId {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyboard.instantiateViewController(withIdentifier: storyboardID)
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}
