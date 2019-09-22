//
//  FilterNames.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 6/25/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//
//  Linter overrides
//

import Foundation

/**
 Filter names used specifically for knighthacks app
 */
internal enum FilterNames: String {
    case food = "Food"
    case talk = "Talk"
    case workshop = "Workshop"
    case mainEvent = "Main Event"
    case all = "All"
    case internships = "internships"
    case fullTime = "full-time"
    case partTime = "part-time"
    case development = "development"
    case hardware = "hardware"
    case beginner = "beginner"
    case advanced = "advanced"
    case career = "career"
    case design = "design"
    case local = "local"
    case unset = "nil"
}

public let defaultAllFilter = FilterNames.all.rawValue

public let dummyScheduleFilterMenu = [
    FilterMenuModel(name: FilterNames.food.rawValue),
    FilterMenuModel(name: FilterNames.talk.rawValue),
    FilterMenuModel(name: FilterNames.workshop.rawValue),
    FilterMenuModel(name: FilterNames.mainEvent.rawValue),
    FilterMenuModel(name: defaultAllFilter)
]

public let dummyWorkshopFilterMenu = [
    FilterMenuModel(name: FilterNames.hardware.rawValue),
    FilterMenuModel(name: FilterNames.beginner.rawValue),
    FilterMenuModel(name: FilterNames.advanced.rawValue),
    FilterMenuModel(name: FilterNames.career.rawValue),
    FilterMenuModel(name: FilterNames.design.rawValue),
    FilterMenuModel(name: FilterNames.development.rawValue),
    FilterMenuModel(name: defaultAllFilter)
]

public let dummySponsorFilterMenu = [
    FilterMenuModel(name: FilterNames.partTime.rawValue),
    FilterMenuModel(name: FilterNames.internships.rawValue),
    FilterMenuModel(name: FilterNames.fullTime.rawValue),
    FilterMenuModel(name: defaultAllFilter)
]

public let dummySponsorFilterGroup = [
    [
        FilterMenuModel(name: FilterNames.partTime.rawValue),
        FilterMenuModel(name: FilterNames.internships.rawValue)
    ],
    [
        FilterMenuModel(name: FilterNames.internships.rawValue),
        FilterMenuModel(name: FilterNames.fullTime.rawValue)
    ],
    [
        FilterMenuModel(name: FilterNames.partTime.rawValue),
        FilterMenuModel(name: FilterNames.fullTime.rawValue)
    ],
    [
        FilterMenuModel(name: FilterNames.partTime.rawValue),
        FilterMenuModel(name: FilterNames.internships.rawValue),
        FilterMenuModel(name: FilterNames.fullTime.rawValue)
    ]
]

public let dummyScheduleFilterGroup = [
    [
        FilterMenuModel(name: FilterNames.talk.rawValue),
        FilterMenuModel(name: FilterNames.workshop.rawValue)
    ],
    [
        FilterMenuModel(name: FilterNames.workshop.rawValue),
        FilterMenuModel(name: FilterNames.mainEvent.rawValue)
    ],
    [
        FilterMenuModel(name: FilterNames.food.rawValue),
        FilterMenuModel(name: FilterNames.talk.rawValue)
    ],
    [
        FilterMenuModel(name: FilterNames.food.rawValue),
        FilterMenuModel(name: FilterNames.workshop.rawValue)
    ]
]

public let dummyWorkshopFilterGroup = [
    [
        FilterMenuModel(name: FilterNames.hardware.rawValue),
        FilterMenuModel(name: FilterNames.beginner.rawValue)
    ],
    [
        FilterMenuModel(name: FilterNames.advanced.rawValue),
        FilterMenuModel(name: FilterNames.career.rawValue)
    ],
    [
        FilterMenuModel(name: FilterNames.design.rawValue),
        FilterMenuModel(name: FilterNames.development.rawValue)
    ],
    [
        FilterMenuModel(name: FilterNames.advanced.rawValue),
        FilterMenuModel(name: FilterNames.career.rawValue),
        FilterMenuModel(name: FilterNames.design.rawValue)
    ]
]
