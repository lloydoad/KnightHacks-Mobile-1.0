//
//  ServiceTests.swift
//  KnightHacksTests
//
//  Created by Lloyd Dapaah on 8/3/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import XCTest
import Firebase
@testable import KnightHacks

class ServiceTests: XCTestCase {

    func testUrlParse() {
        let url = URL(string: Route.server.rawValue + Route.SubRoute.schedule.rawValue)
        let expectedString = Route.server.rawValue + Route.SubRoute.schedule.rawValue
        
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.absoluteString, expectedString)
    }
    
    func testFetchingDummyLiveupdateData() {
        
        let expectation = XCTestExpectation(description: "Done")
        
        let dummyUrl = URL(string: Route.altserver + Route.SubRoute.liveupdate)
        let singleton = RequestSingleton<CodableLiveUpdateModel>()
        
        singleton.makeRequest(url: dummyUrl) { (results) in
            expectation.fulfill()
            if results == nil || results?.isEmpty ?? false {
                XCTFail()
            } else {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFetchingDummyWorkshopData() {
        
        let expectation = XCTestExpectation(description: "Done")
        
        let dummyUrl = URL(string: Route.altserver + Route.SubRoute.workshop)
        let singleton = RequestSingleton<CodableWorkshopModel>()
        
        singleton.makeRequest(url: dummyUrl) { (results) in
            expectation.fulfill()
            if results == nil || results?.isEmpty ?? false {
                XCTFail()
            } else {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testRequestSingletonConnection() {
        let expectation = XCTestExpectation(description: "Done")
        
        let dummyUrl = URL(string: "https://5d3a68a3fa091c0014470961.mockapi.io/connect/schedule")
        let singleton = RequestSingleton<CodableScheduleModel>()
        singleton.makeRequest(url: dummyUrl) { (results) in
            expectation.fulfill()
            if results == nil || results?.isEmpty ?? false {
                XCTFail()
            } else {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    struct FAQMap {
        var question: String
        var answer: String
        
        init(dictionary: [String:Any]) {
            self.question = dictionary["question"] as? String ?? ""
            self.answer = dictionary["answer"] as? String ?? ""
        }
    }
    
    func testRetrievingFirebaseData() {
        
        let expectation = XCTestExpectation(description: "Done")
        let database = Firestore.firestore()
        
        database.collection("faqs").getDocuments { (querySnapshot, error) in
            if let err = error {
                print("Error getting documents: \(err)")
            } else {
                var results: [FAQMap] = []
                querySnapshot?.documents.forEach({ queryDocumentSnapshot in
                    results.append(FAQMap(dictionary: queryDocumentSnapshot.data()))
                })
                
                print(results)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGenericFirebaseRequest() {
        let expectation = XCTestExpectation(description: "Done")
        
        FirebaseRequestSingleton<WorkshopDictionaryModel>().makeRequest(endpoint: .workshops) { (results) in
            if results.isEmpty {
                XCTFail()
            } else {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
