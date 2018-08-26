//
//  ViewController.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 8/26/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    var sampleTable: [Int] = [1,1,1,1,1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 130
        self.tableView.separatorStyle = .none
        self.tableView.register(menuItemTableViewCell.self, forCellReuseIdentifier: menuItemTableViewCell.identifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }

    func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "KnightHacks"
    }
    
    // MARK: - TABLE DATASOURCE FUNCTIONS
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        cell.textLabel?.text = "\(sampleTable[indexPath.row])"
//        return cell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: menuItemTableViewCell.identifier, for: indexPath) as! menuItemTableViewCell
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleTable.count
    }
    
    // MARK: - TABLE DELEGATE FUNCTIONS

}

