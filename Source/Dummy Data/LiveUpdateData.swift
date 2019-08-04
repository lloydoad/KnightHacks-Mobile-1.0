//
//  LiveUpdateData.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/25/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//
//  Linter Overrides
//  swiftlint:disable force_unwrapping

import Foundation

private let dateEngine = DateEngine(format: DateFormat.slashYearMonthDay24HourMinute)

let dummyFirstUpdate: [LiveUpdateModel] = [
    LiveUpdateModel(
        title: "Snacks provided by Insomnia Cookies serving now 🤸🏻‍♂️",
        date: dateEngine.getDate(from: "2019/07/25/21/00")!,
        time: "9:00pm"
    ),
    LiveUpdateModel(
        title: "Facebook is passing out shirts in 15 minutes!",
        date: dateEngine.getDate(from: "2019/07/25/21/41")!,
        time: "9:41pm"
    ),
    LiveUpdateModel(
        title: "React Workshop is starting NOW!",
        date: dateEngine.getDate(from: "2019/07/25/21/15")!,
        time: "9:15pm"
    ),
    LiveUpdateModel(
        title: "Snacks provided by Brain dead Cookies serving now",
        date: dateEngine.getDate(from: "2019/07/25/21/00")!,
        time: "9:30pm"
    )
]

let dummySecondUpdate: [LiveUpdateModel] = [
    LiveUpdateModel(
        title: "🤸🏻‍♂️ Look out Knightro is coming at you",
        date: dateEngine.getDate(from: "2019/07/26/22/00")!,
        time: "10:00pm"
    ),
    LiveUpdateModel(
        title: "Theres more rice and beans!",
        date: dateEngine.getDate(from: "2019/07/26/22/11")!,
        time: "10:11pm"
    ),
    LiveUpdateModel(
        title: "Goodmorning!",
        date: dateEngine.getDate(from: "2019/07/28/07/15")!,
        time: "7:15am"
    )
]
