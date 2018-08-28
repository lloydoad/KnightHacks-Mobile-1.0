//
//  ScheduleTableViewController.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 8/28/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

class ScheduleTableViewController: UITableViewController{
    var sampleEventData: [Int] = [1,1,1,1,1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup navigation bar
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: 0x5755D6, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // Setup tableview
        self.tableView.estimatedRowHeight = COMBINED_FILTER_HEIGHT - NAVBAR_HEIGHT - 10
        self.tableView.register(FilterMenuTableViewCell.self, forCellReuseIdentifier: FilterMenuTableViewCell.identifier)
        self.view.backgroundColor = .white
        colorBounceView(with: BACKGROUND_COLOR)
    }
    
    // Change the color of space between tablview and navbar
    func colorBounceView(with color: UIColor) {
        var frame = self.view.bounds
        frame.origin.y = -frame.size.height
        
        let view = UIView(frame: frame)
        view.backgroundColor = color
        
        self.view.addSubview(view)
    }
    
    // MARK: - TABLE DATASOURCE FUNCTIONS
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: FilterMenuTableViewCell.identifier, for: indexPath) as! FilterMenuTableViewCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell.textLabel?.text = "TEST"
        }
        
        return cell
    }
    
    // return a customized height for filter menu cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return COMBINED_FILTER_HEIGHT - NAVBAR_HEIGHT
        } else {
            return 60
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // return number of events + filter menu
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleEventData.count + 1
    }
    
    // MARK: - TABLE DELEGATE FUNCTIONS

    
    
    
    
}
