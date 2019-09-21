//
//  FrequentlyAskedViewController.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/28/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

internal class FrequentlyAskedViewController: NavigationBarTableViewController, NavigationBarViewControllerExtension, ModelObserver {
    
    internal static let identifier: String = "FrequentlyAskedTableViewController"
    
    private var viewModel: FrequentlyAskedViewControllerModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = FrequentlyAskedViewControllerModel()
        viewModel.observer = self
        
        self.colorUpper(view: tableView, with: BACKGROUND_COLOR)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.fetchFrequentlyAskedData()
        
        self.add(navigationController: navigationController, and: navigationItem, with: BACKGROUND_COLOR)
        self.updateNavigationTitle()
    }
    
    private func updateNavigationTitle() {
        self.navigationItem.title = "Frequently Asked"
        self.navigationController?.navigationBar.tintColor = .white
        
        if #available(iOS 11, *) {
            self.navigationItem.largeTitleDisplayMode = .always
            self.navigationController?.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: CELL_HEADER_FONT
            ]
        }
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        super.addBackgroundView(using: viewModel.viewContent)
        return viewModel.viewContent.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: FrequentlyAskedTableViewCell.identifier, for: indexPath) as? FrequentlyAskedTableViewCell,
            indexPath.row < viewModel.viewContent.count else {
            return UITableViewCell()
        }
        
        cell.expandContractButton.addTarget(self, action: #selector(hideOrDisplayDetails(sender:)), for: .touchUpInside)
        cell.model = viewModel.viewContent[indexPath.row]
        cell.expandContractButton.tag = indexPath.row
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < self.viewModel.viewContent.count else {
            return
        }
        let tagHolderButton = UIButton()
        tagHolderButton.tag = indexPath.row
        self.hideOrDisplayDetails(sender: tagHolderButton)
    }
    
    @objc func hideOrDisplayDetails(sender: UIButton) {
        self.viewModel.toggleQuestion(at: sender.tag)
        self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
    }
    
    // MARK: - View model delegate
    
    func didFetchModel() {
        self.tableView.reloadData()
    }
}
