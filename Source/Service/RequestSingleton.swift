//
//  Singleton.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 8/3/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

internal class RequestSingleton<Model: Codable> {
    
    let scheduleURL = URL(string: Route.server + Route.SubRoute.schedule)
    let sponsorURL = URL(string: Route.server + Route.SubRoute.sponsor)
    
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
