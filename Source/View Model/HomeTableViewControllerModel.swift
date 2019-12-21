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
        HomeMenuModel(title: "Schedule", color: SCHEDULE_MENU_COLOR, viewControllerID: ScheduleTableViewController.identifier),
        HomeMenuModel(title: "Live Updates", color: LIVE_UPDATES_MENU_COLOR, viewControllerID: LiveUpdatesTableViewController.identifier),
        HomeMenuModel(title: "FAQs", color: FAQS_MENU_COLOR, viewControllerID: FrequentlyAskedViewController.identifier),
        HomeMenuModel(title: "Workshops", color: WORKSHOPS_MENU_COLOR, viewControllerID: WorkshopTableViewController.identifier),
        HomeMenuModel(title: "Sponsors", color: SPONSORS_MENU_COLOR, viewControllerID: SponsorsTableViewController.identifier),
        HomeMenuModel(title: "Profile", color: BLUE_COLOR, viewControllerID: ProfileViewController.identifier)
    ]
}
