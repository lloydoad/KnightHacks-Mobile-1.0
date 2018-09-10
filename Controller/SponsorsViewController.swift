//
//  SponsorsViewController.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 9/6/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

class SponsorsViewController: CustomTableViewController {
    // Model has to be in the form [(String, [Int])]
    
    // Make changes to default view settings
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // remove headers
        hasHeaders = false
        
        //        update model with api
        //        tableDataContent = sampleRetrievedData
        //        otherRowHeight = 107
    }
}
