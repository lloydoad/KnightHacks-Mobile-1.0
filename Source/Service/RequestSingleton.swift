//
//  Singleton.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 8/3/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation
import Firebase

internal class RequestSingleton<Model: Codable> {
    
    let scheduleURL = URL(string: Route.server + Route.SubRoute.schedule)
    let sponsorURL = URL(string: Route.server + Route.SubRoute.sponsor)
    let workshopURL = URL(string: Route.altserver + Route.SubRoute.workshop)
    let liveUpdateURL = URL(string: Route.altserver + Route.SubRoute.liveupdate)
    let faqsURL = URL(string: Route.altserver + Route.SubRoute.faqs)
    
    func makeRequest(url: URL?, completion: @escaping ([Model]?) -> Void) {
        
        guard let unwrappedUrl = url else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: unwrappedUrl) { (data, _, err) in
            DispatchQueue.main.async {
                
                if let err = err {
                    print(err)
                    completion(nil)
                    return
                }
                
                guard let data = data else {
                    completion(nil)
                    return
                }
                
                completion(try? JSONDecoder().decode([Model].self, from: data))
            }
        }
        
        task.resume()
    }
}

internal class FirebaseRequestSingleton<ModelDictionary: DictionaryCodable> {
    
    enum FirebaseRequestEndpoints: String {
        case liveUpdates = "live_updates"
        case workshops
        case sponsors
        case filters
        case events
        case faqs
    }
    
    func makeRequest(endpoint: FirebaseRequestEndpoints, completion: @escaping ([ModelDictionary]) -> Void) {
        
        let databaseReference = Database.database().reference()
        databaseReference.child(endpoint.rawValue).observeSingleEvent(of: .value) { (snapshot) in
            DispatchQueue.main.async {
                
                guard let value = snapshot.value as? [String: Any] else {
                    completion([])
                    return
                }
                
                var results: [ModelDictionary] = []
                value.forEach({ (_, value) in
                    if
                        let unwrappedValue = value as? NSDictionary,
                        let object = try? ModelDictionary(dataRecieved: unwrappedValue) {
                        results.append(object)
                    }
                })
                
                completion(results)
            }
        }
    }
}
