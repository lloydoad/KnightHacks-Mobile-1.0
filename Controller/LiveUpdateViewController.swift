//
//  LiveUpdateTableViewController.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 9/17/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

class LiveUpdatesViewController: ParentTableView {
    var liveUpdateContent: [LiveUpdateObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DynamicTableViewCell.identifier, for: indexPath) as! DynamicTableViewCell
        cell.cellType = .leftImageCell
        cell.contentImageView?.image = #imageLiteral(resourceName: "knight hacks image")
        cell.selectionStyle = .none
        return cell
    }
}
