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
    
    override public func willMove(toParent parent: UIViewController?) {
        self.navigationController?.navigationBar.barTintColor = .white
    }
}

/**
 A UITableViewController subclass for undoing navigation controller customizations when child views are popped.
 */
public class NavigationBarTableViewController: UITableViewController {
    
    override public func willMove(toParent parent: UIViewController?) {
        self.navigationController?.navigationBar.barTintColor = .white
    }
}
