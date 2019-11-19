//
//  HomeTableViewControllerViewModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 6/23/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

internal struct HomeTableViewControllerModel {
    
    let heightForRow: Float = 130
    
    var menuItems: [HomeMenuModel] = [
        HomeMenuModel(title: "Schedule", color: ORANGE_COLOR, viewControllerID: ScheduleTableViewController.identifier),
        HomeMenuModel(title: "Live Updates", color: BLUE_COLOR, viewControllerID: LiveUpdatesTableViewController.identifier),
        HomeMenuModel(title: "FAQs", color: GREEN_COLOR, viewControllerID: FrequentlyAskedViewController.identifier),
        HomeMenuModel(title: "Workshops", color: RED_COLOR, viewControllerID: WorkshopTableViewController.identifier),
        HomeMenuModel(title: "Sponsors", color: BACKGROUND_COLOR, viewControllerID: SponsorsTableViewController.identifier),
        HomeMenuModel(title: "Profile", color: BLUE_COLOR, viewControllerID: ProfileViewController.identifier)
    ]
}
