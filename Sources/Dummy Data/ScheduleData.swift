//
//  ScheduleData.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/21/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

fileprivate var dateEngine = DateEngine()

var ScheduleDummyData: [ScheduleModel] = [
    ScheduleModel(
        title: "Check in begins",
        location: "Engineering 2 Atrium",
        time: "6:00pm",
        header: "Friday 4/11",
        date: dateEngine.getDateFrom("2019-4-11")!,
        filters: [.food]
    ),
    ScheduleModel(
        title: "Opening Ceremony",
        location: "MSB 2 Atrium",
        time: "7:00pm",
        header: "Friday 4/11",
        date: dateEngine.getDateFrom("2019-4-11")!,
        filters: [.talk]
    ),
    ScheduleModel(
        title: "Hacking Begins",
        location: "Engineering 2 Atrium",
        time: "8:30pm",
        header: "Friday 4/11",
        date: dateEngine.getDateFrom("2019-4-11")!,
        filters: [.workshop]
    ),
    ScheduleModel(
        title: "Learning Azure with Microsoft",
        location: "ENGR 2 223",
        time: "8:30am",
        header: "Saturday 4/12",
        date: dateEngine.getDateFrom("2019-4-12")!,
        filters: [.mainEvent]
    ),
    ScheduleModel(
        title: "Can you spot the rabbit: Using Google Cloud For Machine Learning",
        location: "Idea Lab 2",
        time: "12:00pm",
        header: "Saturday 4/12",
        date: dateEngine.getDateFrom("2019-4-12")!,
        filters: [.food]
    ),
    ScheduleModel(
        title: "Education Talks",
        location: "MSB 2 Atrium",
        time: "11:00pm",
        header: "Sunday 4/13",
        date: dateEngine.getDateFrom("2019-4-13")!,
        filters: [.talk]
    ),
    ScheduleModel(
        title: "Snacks",
        location: "Starbucks",
        time: "6:00pm",
        header: "Monday 4/14",
        date: dateEngine.getDateFrom("2019-4-14")!,
        filters: [.mainEvent]
    ),
    ScheduleModel(
        title: "Snacks Again",
        location: "Starbucks",
        time: "8:00pm",
        header: "Monday 4/14",
        date: dateEngine.getDateFrom("2019-4-14")!,
        filters: [FilterNames.hardware]
    )
]
