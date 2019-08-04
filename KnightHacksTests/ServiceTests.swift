//
//  ServiceTests.swift
//  KnightHacksTests
//
//  Created by Lloyd Dapaah on 8/3/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import XCTest
@testable import KnightHacks

class ServiceTests: XCTestCase {

    func testUrlParse() {
        let url = URL(string: Route.server.rawValue + Route.SubRoute.schedule.rawValue)
        let expectedString = Route.server.rawValue + Route.SubRoute.schedule.rawValue
        
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.absoluteString, expectedString)
    }
    
    func testRequestSingletonConnection() {
        let expectation = XCTestExpectation(description: "Done")
        
        let dummyUrl = URL(string: "https://5d3a68a3fa091c0014470961.mockapi.io/connect/schedule")
        let singleton = RequestSingleton<CodableScheduleModel>()
        let dateEngine = DateEngine(format: .standardISO1806)
        
        
        singleton.makeRequest(url: dummyUrl) { (results) in
            expectation.fulfill()
            if results == nil || results?.isEmpty ?? false {
                XCTFail()
            } else {
                var models: [ScheduleModel] = []
                
                results?.forEach {
                    if let date = dateEngine.getDate(from: $0.date) {
                        models.append(ScheduleModel(
                            title: $0.title,
                            location: $0.location,
                            time: dateEngine.getString(of: date, as: .hourColonMinuteMeridian),
                            header: dateEngine.getString(of: date, as: .dayMonth),
                            date: date,
                            filters: $0.filters.map { FilterNames(rawValue: $0)! }
                        ))
                    } else {
                        XCTFail()
                    }
                }
                
                print(models)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
