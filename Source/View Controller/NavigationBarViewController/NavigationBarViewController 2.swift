//
//  InternalUIViewController.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 6/27/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

/**
 A UIViewController subclass for undoing navigation controller customizations when child views are popped.
 */
public class NavigationBarViewController: UIViewController {
    
    var viewHasAppeared: Bool = false
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewHasAppeared = true
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewHasAppeared = false
    }
    
    override public func willMove(toParent parent: UIViewController?) {
        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    public func addBackgroundView(to tableView: UITableView, using content: [Any]) {
        if content.isEmpty && viewHasAppeared == true {
            let background = EmptyTableBackgroundView(frame: tableView.frame)
            tableView.backgroundView = background
            background.animateBackground()
        } else {
            tableView.backgroundView = nil
        }
    }
}

/**
 A UITableViewController subclass for undoing navigation controller customizations when child views are popped.
 */
public class NavigationBarTableViewController: UITableViewController {
    
    var viewHasAppeared: Bool = false
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewHasAppeared = true
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewHasAppeared = false
    }
    
    override public func willMove(toParent parent: UIViewController?) {
        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    public func addBackgroundView(using content: [Any]) {
        if content.isEmpty && viewHasAppeared == true {
            let background = EmptyTableBackgroundView(frame: tableView.frame)
            tableView.backgroundView = background
            background.animateBackground()
        } else {
            tableView.backgroundView = nil
        }
    }
}
