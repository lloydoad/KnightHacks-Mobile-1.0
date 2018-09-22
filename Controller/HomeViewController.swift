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
    var menuItems: [MenuButton] =
        [
            MenuButton(name: "Schedule", color: ORANGE_COLOR),
            MenuButton(name: "Live Updates", color: BLUE_COLOR),
            MenuButton(name: "FAQs", color: GREEN_COLOR),
            MenuButton(name: "Workshops", color: RED_COLOR),
            MenuButton(name: "Sponsors", color: BACKGROUND_COLOR)
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

    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 2,
                       delay: 6,
                       
                       animations: {
                        self.navigationController?.navigationBar.alpha = 1
                        self.navigationController?.navigationBar.isHidden = false
        })
    }
    
    // MARK: - TABLE DATASOURCE FUNCTIONS
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemTableViewCell.identifier, for: indexPath) as! MenuItemTableViewCell
        
        cell.customTitleLabel.text = menuItems[indexPath.row].name
        cell.customIconView.image = menuItems[indexPath.row].icon
        cell.customBackground.backgroundColor = menuItems[indexPath.row].color
        
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
        
        switch menuItems[indexPath.row].name {
        case "Schedule":
            let filterButtons: [FilterButton] =
                [
                    FilterButton(input: Filter.NOT_SET),
                    FilterButton(input: Filter.talks),
                    FilterButton(input: Filter.workshops),
                    FilterButton(input: Filter.all)
                ]
            let sampleRetrievedData = [("Friday",[1,1,1]), ("Saturday",[1, 1]), ("Monday", [1,1,1,1,1])]
            
            let nextView = ScheduleViewController(style: .plain, filterOptions: filterButtons, content: sampleRetrievedData)
            self.navigationController?.pushViewController(nextView, animated: true)
            break
        case "Live Updates":
            let nextView = LiveUpdatesViewController(style: .plain)
            self.navigationController?.pushViewController(nextView, animated: true)
            break
        case "Workshops":
            let filterButtons: [FilterButton] =
                [
                    FilterButton(input: Filter.NOT_SET),
                    FilterButton(input: Filter.design),
                    FilterButton(input: Filter.development),
                    FilterButton(input: Filter.all)
            ]
            let sampleRetrievedData = [("Friday",[1,1,1]), ("Saturday",[1, 1]), ("Monday", [1,1,1,1,1])]
            
            let nextView = WorkshopsViewController(style: .plain, filterOptions: filterButtons, content: sampleRetrievedData)
            self.navigationController?.pushViewController(nextView, animated: true)
            break
        case "Sponsors":
            let filterButtons: [FilterButton] =
                [
                    FilterButton(input: Filter.NOT_SET),
                    FilterButton(input: Filter.internships),
                    FilterButton(input: Filter.full_time),
                    FilterButton(input: Filter.all)
            ]
            let sampleRetrievedData = [("Friday",[1,1,1]), ("Saturday",[1, 1]), ("Monday", [1,1,1,1,1])]
            
            let nextView = SponsorsViewController(style: .plain, filterOptions: filterButtons, content: sampleRetrievedData)
            self.navigationController?.pushViewController(nextView, animated: true)
            break
        default:
            break
        }
    }

}

