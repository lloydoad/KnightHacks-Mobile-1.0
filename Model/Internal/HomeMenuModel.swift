//
//  HomeMenuButton.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 6/23/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

internal struct HomeMenuModel {
    
    var title: String
    var imageName: String
    var defaultColor: UIColor
    var connectedViewControllerId: String?
    
    /**
     Initializes model content of HomeMenu Button
     - Button title is formatted as-is for labels
     - Button images are constructed from the first image asset named "menu-<title>"
     */
    init(title: String, color: UIColor, viewControllerID: String?) {
        self.title = title
        self.defaultColor = color
        self.imageName = "menu-\(title.lowercased())"
        self.connectedViewControllerId = viewControllerID
    }
}
