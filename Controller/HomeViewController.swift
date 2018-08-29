//
//  ViewController.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 8/26/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    // title and colors for each cell
    var menuItems: [String] = ["Schedule", "Live Updates", "FAQs", "Workshops", "Sponsors"]
    let cellColors: [UIColor] =
        [
            UIColor(hex: 0xFF9500, alpha: 1),
            UIColor(hex: 0x057AFF, alpha: 1),
            UIColor(hex: 0x26AE60, alpha: 1),
            UIColor(hex: 0xFF3B31, alpha: 1),
            UIColor(hex: 0x5755D6, alpha: 1)
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set constant height of cells and remove default separators
        self.tableView.rowHeight = 130
        self.tableView.separatorStyle = .none
        self.tableView.register(MenuItemTableViewCell.self, forCellReuseIdentifier: MenuItemTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // setup navigation
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Where to?"
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.view.backgroundColor = .white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - TABLE DATASOURCE FUNCTIONS
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemTableViewCell.identifier, for: indexPath) as! MenuItemTableViewCell
        
        cell.customTitleLabel.text = menuItems[indexPath.row]
        cell.customIconView.image = UIImage(named: menuItems[indexPath.row].lowercased())
        cell.customBackground.backgroundColor = cellColors[indexPath.row]
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // return number of menu options
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    // MARK: - TABLE DELEGATE FUNCTIONS
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch menuItems[indexPath.row] {
        case "Schedule":
            let nextView = ScheduleTableViewController()
            self.navigationController?.pushViewController(nextView, animated: true)
            break
        default:
            break
        }
    }

}

