//
//  RequestSingleton.swift
//  KnightHacks
//
//  Created by KnightHacks on 10/30/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import Alamofire
import SwiftyJSON
import Foundation

class RequestSingleton {
    static let baseUrl = "https://test-knight-hacks.appspot.com"
    
    static func getData(at url: String, params: [String:String]? ,completion: @escaping (JSON?)->Void) {
        
        guard let fullUrl = URL(string: url) else {
            completion(nil)
            return
        }
        
        Alamofire.request(fullUrl, method: .get, parameters: params).validate().responseJSON { (response) in
            guard let value = response.result.value else {
                completion(nil)
                return
            }
            
            let json = JSON(value)
            completion(json);
        }
    }
}
