//
//  ParentTableView.swift
//  KnightHacks
//
//  Created by KnightHacks on 9/17/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

class ParentTableView: UITableViewController {
    
    var emptyBackgroundView: UIView!
    var isEmpty: Bool = true {
        didSet {
            toggleEmptyView()
        }
    }
    
    // register cell and match space on top of table with navigation bar
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundView = UIView(frame: self.tableView.frame)
        self.emptyBackgroundView = setEmptyViewBackground(of: self.tableView)
        
        tableView.separatorStyle = .none
        tableView.register(DynamicTableViewCell.self, forCellReuseIdentifier: DynamicTableViewCell.identifier)
        colorUpperTableViewSpace(with: BACKGROUND_COLOR)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // setup navigation bar
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    private func toggleEmptyView() {
        if isEmpty {
            self.emptyBackgroundView.alpha = 1
        } else {
            self.emptyBackgroundView.alpha = 0
        }
    }
    
    private func setEmptyViewBackground(of view: UIView) -> UIView {
        let stackView = UIStackView(frame: view.frame)
        
        boundEdges(of: stackView, to: view, with: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        stackView.backgroundColor = UIColor.blue
        
        // add the image
        // add random quote
        
        return stackView
    }
    
    // setup navigation bar ui
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = BACKGROUND_COLOR
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = .white
        
        if #available(iOS 11, *) {
            self.navigationItem.largeTitleDisplayMode = .never
        }
    }
    
    // change the color of space between tableview and navbar
    private func colorUpperTableViewSpace(with color: UIColor) {
        var frame = self.view.bounds
        frame.origin.y = -frame.size.height
        
        let view = UIView(frame: frame)
        view.backgroundColor = color
        
        self.view.addSubview(view)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    // change navigation bar of parent view to white
    override func willMove(toParent parent: UIViewController?) {
        self.navigationController?.navigationBar.barTintColor = .white
        if #available(iOS 11, *) {
            self.navigationController?.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: CELL_HEADER_FONT
            ]
        }

        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
}
