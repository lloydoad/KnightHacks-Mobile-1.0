//
//  WorkshopData.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/25/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//
//  Linter Overrides
//  swiftlint:disable force_unwrapping

import Foundation

private var dateEngine = DateEngine(format: .slashYearMonthDay24HourMinute)

let dummyWorkshopData: [WorkshopModel] = [
    WorkshopModel(
        date: dateEngine.getDateFrom("2019/4/11/21/15")!,
        time: "9:15pm",
        title: "React Workshop",
        header: "Friday 4/11",
        imageURL: nil,
        description: "Learn about the trendiest web development library on the planet. Build a simple todo list with React in Javascript. (45 mins)",
        filters: [.beginner]
    ),
    WorkshopModel(
        date: dateEngine.getDateFrom("2019/4/11/22/15")!,
        time: "10:15pm",
        title: "Angular Workshop",
        header: "Friday 4/11",
        description: "Learn about the trendiest web development library on the planet. Build a simple todo list with React in Javascript. (45 mins)",
        filters: [.development]
    )
]
