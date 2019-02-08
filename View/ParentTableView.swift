//
//  ParentTableView.swift
//  KnightHacks
//
//  Created by KnightHacks on 9/17/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

class ParentTableView: UITableViewController {
    let imageDimension: CGFloat = 120
    let topOffsetConstant: CGFloat = 140
    let centerOffsetConstant: CGFloat = -7
    let minimumLabelHeight: CGFloat = 26
    
    var containerCenterOffset: NSLayoutConstraint?
    var emptyBackgroundView: UIView?
    var hasViewAppeared: Bool = false
    var isEmpty: Bool = false {
        didSet {
            self.toggleEmptyView()
        }
    }
    
    // register cell and match space on top of table with navigation bar
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .none
        self.tableView.backgroundView = UIView(frame: self.tableView.frame)
        self.tableView.register(DynamicTableViewCell.self, forCellReuseIdentifier: DynamicTableViewCell.identifier)
        
        self.colorUpperTableViewSpace(with: BACKGROUND_COLOR)
        self.emptyBackgroundView = setEmptyViewBackground(of: self.tableView.backgroundView ?? UIView())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // setup navigation bar
        super.viewWillAppear(animated)
        self.setupNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.hasViewAppeared = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hasViewAppeared = false
        toggleEmptyView()
    }
    
    private func toggleEmptyView() {
        if isEmpty && hasViewAppeared {
            UIView.animate(withDuration: 0.3) {
                self.emptyBackgroundView?.alpha = 1
                self.containerCenterOffset?.constant = 0
                self.view.layoutIfNeeded()
            }
        } else {
            self.containerCenterOffset?.constant = -5
            self.emptyBackgroundView?.alpha = 0
        }
    }
    
    private func setEmptyViewBackground(of view: UIView) -> UIView {
        let containerStackView = getPresetUIStackView(axis: .vertical, alignment: .center, distribution: .fillProportionally, spacing: 0)
        let roverImageView = UIImageView(image: UIImage(named: "rover"))
        let message = createFormattedLabel(type: .paragraph, defaultText: "Cannot find any signs of life.", alignment: .center)
        
        view.addSubview(containerStackView)
        containerStackView.alpha = 0
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: topOffsetConstant).isActive = true
        containerCenterOffset = containerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: centerOffsetConstant)
        containerCenterOffset?.isActive = true
        
        roverImageView.translatesAutoresizingMaskIntoConstraints = false
        roverImageView.heightAnchor.constraint(equalToConstant: imageDimension).isActive = true
        roverImageView.widthAnchor.constraint(equalToConstant: imageDimension).isActive = true
        
        message.textColor = BACKGROUND_COLOR
        message.translatesAutoresizingMaskIntoConstraints = false
        message.heightAnchor.constraint(greaterThanOrEqualToConstant: minimumLabelHeight).isActive = true
        
        containerStackView.addArrangedSubview(roverImageView)
        containerStackView.addArrangedSubview(message)
        
        return containerStackView
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
