//
//  BaseTableView.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 9/17/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

class ParentTableView: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(DynamicTableViewCell.self, forCellReuseIdentifier: DynamicTableViewCell.identifier)
        colorUpperTableViewSpace(with: BACKGROUND_COLOR)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Setup navigation bar
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = BACKGROUND_COLOR
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    // Change the color of space between tableview and navbar
    func colorUpperTableViewSpace(with color: UIColor) {
        var frame = self.view.bounds
        frame.origin.y = -frame.size.height
        
        let view = UIView(frame: frame)
        view.backgroundColor = color
        
        self.view.addSubview(view)
    }
    
    // Change navigation bar of parent view to white
    override func willMove(toParentViewController parent: UIViewController?) {
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
    }
}
