//
//  FrequentlyAskedViewController.swift
//  KnightHacks
//
//  Created by KnightHacks on 9/18/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

class FrequentlyAskedViewController: ParentTableView {
    var isCellReduced: [Bool] = []
    var frequentlyAskedQuestionsContent: [FrequentlyAskedQuestionsObject] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var refreshControlView: UIRefreshControl?
    
    let GET_FREQUENTLY_ASKED_QUESTIONS_URL: String = RequestSingleton.BASE_URL + "/api/get_faqs"
    let DEFAULT_FREQUENTLY_ASKED_QUESTIONS_OBJECT: FrequentlyAskedQuestionsObject = FrequentlyAskedQuestionsObject(
        question: "Question", answer: "Answer"
    )
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFrequentlyAskedQuestions()
        setupNavigationBarUIElements()
    }
    
    func getFrequentlyAskedQuestions() {

        RequestSingleton.getData(at: GET_FREQUENTLY_ASKED_QUESTIONS_URL, with: nil) { (responseArray) in
            guard let responseArray = responseArray else {
                if self.isViewLoaded && self.view.window != nil {
                    let errorCallBack = ErrorPopUpViewController(message: nil)
                    errorCallBack.present()
                }
                return
            }
            
            for response in responseArray {
                let singleFrequentlyAskedQuestionsObject = FrequentlyAskedQuestionsObject(json: response)
                self.frequentlyAskedQuestionsContent.append(singleFrequentlyAskedQuestionsObject)
                self.isCellReduced.append(true)
            }
        }
    }
    
    func setupNavigationBarUIElements() {
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.frequentlyAskedQuestionsContent.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DynamicTableViewCell.identifier, for: indexPath) as! DynamicTableViewCell
        cell.cellType = .hiddenDetailedCell
        cell.isShowingDetails = !isCellReduced[indexPath.row]
        cell.titleLabel?.text = frequentlyAskedQuestionsContent[indexPath.row].question
        cell.itemDescriptionLabel?.text = frequentlyAskedQuestionsContent[indexPath.row].answer
        cell.showMoreButton?.tag = indexPath.row
        cell.showMoreButton?.addTarget(self, action: #selector(expandOrShrinkCell(sender:)), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func expandOrShrinkCell(sender: UIButton) {
        isCellReduced[sender.tag] = !isCellReduced[sender.tag]

        tableView.allowsSelectionDuringEditing = false
        tableView.beginUpdates()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
        tableView.endUpdates()
    }
    
}
