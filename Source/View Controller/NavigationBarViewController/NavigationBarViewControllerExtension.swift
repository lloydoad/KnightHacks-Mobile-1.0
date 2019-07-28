//
//  InternalUIViewControllerDelegate.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/22/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

/**
 A protocol with abstractions for adding common features to a tableview such as:
 * Changing the color of tableview header spaces
 * Attaching a tableview to a view controller
 * Creating navigation controllers that blend into child view controllers
 - NOTE: These functions are not required and must be called explicitly if needed
 */
public protocol NavigationBarViewControllerExtension { }

extension NavigationBarViewControllerExtension {
    /**
     Converts the navigation controller and bar (when available) of the current view to the specified color
     - parameters:
     - color: navigation background color
     - tint: navigation tint color
     */
    public func add(navigationController: UINavigationController?, and navigationItem: UINavigationItem, with color: UIColor, tint: UIColor = .white) {
        navigationController?.navigationBar.barTintColor = color
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = tint
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    /**
     Changes the color of the upper portion of a view to specified color. Although this function is open for further uses, it's intended for setting the color of overscroll for tableviews and other scroll view types.
     */
    func colorUpper(view: UIView, with color: UIColor) {
        let frame = CGRect(x: 0, y: -view.frame.height, width: view.frame.width * 2, height: view.frame.height)
        let space = UIView(frame: frame)
        space.backgroundColor = color
        view.addSubview(space)
    }
    
    /**
     Abstraction function for setting delegate and dataSource for self implemented protocol
     */
    func attach(table: UITableView, toDelegate delegate: UITableViewDelegate, andDataSource dataSource: UITableViewDataSource) {
        table.delegate = delegate
        table.dataSource = dataSource
    }
}
