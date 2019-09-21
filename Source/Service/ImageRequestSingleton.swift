//
//  ImageRequestSingleton.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 8/3/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

internal struct ImageRequestSingleton {
    
    static func getImage(at url: String, completion: @escaping (UIImage?) -> Void) {
        
        var validatedUrlString = url
        let httpsText = "https://"
        let httpText = "http://"
        var decodedImage: UIImage!
        let dataTest: Data? = nil
        
        // if prefix has no http:// append https://
        // if it is http:// change to https://
        if String(url.prefix(httpText.count)) == httpText {
            validatedUrlString = httpsText + String(url.suffix(url.count - httpText.count))
        } else if String(url.prefix(httpsText.count)) != httpsText {
            validatedUrlString = httpsText + url
        }
        
        guard let validatedUrl = URL(string: validatedUrlString) else {
            print("Error: Invalid URL request")
            completion(nil)
            return
        }
        
        UIImage.cacheStorageCheck(at: validatedUrlString, imageData: dataTest, completion: { (cachedImage) in
            
            guard cachedImage == nil else {
                decodedImage = cachedImage
                completion(decodedImage)
                return
            }
            
            let task = URLSession.shared.dataTask(with: validatedUrl) { (data, _, err) in
                
                DispatchQueue.main.async {
                    
                    if let err = err {
                        completion(nil)
                        print(err)
                        return
                    }
                    
                    guard let imageData = data else {
                        completion(nil)
                        print("Error: Could not convert response to Data")
                        return
                    }
                    
                    UIImage.cacheImage(with: validatedUrlString, data: imageData)
                    completion(decodedImage)
                }
            }
            
            task.resume()
        })
    }
}
