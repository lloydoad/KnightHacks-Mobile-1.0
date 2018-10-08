//
//  HomeViewController.swift
//  KnightHacks
//
//  Created by KnightHacks on 8/26/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    let cellHeights: CGFloat = 130
    
    // MARK: - SETUP UI AND UI CONTENT
    
    // content color and title for each cell
    var menuItems: [MenuButton] =
        [
            MenuButton(name: HomeViewSection.schedule.rawValue, color: ORANGE_COLOR),
            MenuButton(name: HomeViewSection.liveUpdates.rawValue, color: BLUE_COLOR),
            MenuButton(name: HomeViewSection.faqs.rawValue, color: GREEN_COLOR),
            MenuButton(name: HomeViewSection.workshops.rawValue, color: RED_COLOR),
            MenuButton(name: HomeViewSection.sponsors.rawValue, color: BACKGROUND_COLOR)
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set constant height of cells and remove default separators
        self.tableView.rowHeight = cellHeights
        self.tableView.separatorStyle = .none
        
        // register cell
        self.tableView.register(MenuItemTableViewCell.self, forCellReuseIdentifier: MenuItemTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationbar()
    }
    
    func setupNavigationbar() {
        if #available(iOS 11, *) { self.navigationController?.navigationBar.prefersLargeTitles = true }
        self.navigationItem.title = "Where to?"
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.view.backgroundColor = .white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    // MARK: - TABLE DATASOURCE FUNCTIONS
    
    // setup content of a cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemTableViewCell.identifier, for: indexPath) as! MenuItemTableViewCell
        
        cell.customTitleLabel.text = menuItems[indexPath.row].name
        cell.customIconView.image = menuItems[indexPath.row].icon
        cell.customBackground.backgroundColor = menuItems[indexPath.row].color
        
        return cell
    }
    
    // get number of cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    // MARK: - TABLE DELEGATE FUNCTIONS
    
    // determine next view from cell selection
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.navigationController?.pushViewController(determineNextViewController(indexpath: indexPath), animated: true)
    }
    
    func determineNextViewController(indexpath: IndexPath) -> UIViewController {
        
        switch menuItems[indexpath.row].name {
        case HomeViewSection.schedule.rawValue:
            return ScheduleViewController(style: .plain)
        case HomeViewSection.liveUpdates.rawValue:
            return LiveUpdatesViewController(style: .plain)
        case HomeViewSection.workshops.rawValue:
            return WorkshopsViewController(style: .plain)
        case HomeViewSection.sponsors.rawValue:
            return SponsorsViewController(style: .plain)
        case HomeViewSection.faqs.rawValue:
            return FrequentlyAskedViewController(style: .plain)
        default:
            return ScheduleViewController(style: .plain)
        }
    }
}

