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
    static let BASE_URL = "https://test-knight-hacks.appspot.com"
    
    static func getData(at url: String, with params: [String:String]?, completion: @escaping ([JSON]?) -> Void) {
        
        guard let fullUrl = URL(string: url) else {
            completion(nil)
            print("Error: Invalid URL string")
            return
        }
        
        Alamofire.request(fullUrl, method: .get, parameters: params).validate().responseJSON { (response) in
            DispatchQueue.main.async {
                guard let value = response.result.value else {
                    completion(nil)
                    print(response.error ?? "Error: Invalid request")
                    return
                }
                
                let rawJSON = JSON(value)
                var arrayJSON: [JSON] = []
                for (_,subJson):(String, JSON) in rawJSON {
                    arrayJSON.append(subJson)
                }
                completion(arrayJSON);
            }
        }
    }
    
    // temp function for retrieving images, this will either be replaced with the image cache or will integrate the image depending on how the image cache is setup
    static func getImage(at url: String, completion: @escaping (UIImage?) -> Void) {
        var validatedUrlString = url
        let httpsText = "https://"
        let httpText = "http://"
        
        // if prefix has no http:// append http://
        // if it is http, change to https
        if String(url.prefix(httpsText.count)) != httpsText {
            validatedUrlString = httpsText + url
        } else {
            validatedUrlString = httpsText + String(url.suffix(url.count - httpText.count))
        }
        
        guard let validatedUrl = URL(string: validatedUrlString) else {
            print("Error: Invalid URL request")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: validatedUrl) { (data, res, err) in
            DispatchQueue.main.async {
                if(err != nil) {
                    completion(nil)
                    print(err!)
                    return
                }
                
                guard let imageData = data else {
                    completion(nil)
                    print("Error: Could not convert response to Data")
                    return
                }
                
                guard let decodedImage = UIImage(data: imageData) else {
                    completion(nil)
                    print("Error: Could not convert Data to UIImage")
                    return
                }

                completion(decodedImage)
            }
        }
        task.resume()
    }
}
