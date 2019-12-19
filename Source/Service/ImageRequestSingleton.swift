//
//  ImageRequestSingleton.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 8/3/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit
import Firebase

internal struct ImageRequestSingleton {
    
    static func getImage(at url: String, completion: @escaping (UIImage?) -> Void) {
        
        var validatedUrlString = url
        let httpsText = "https://"
        let httpText = "http://"
        var decodedImage: UIImage!
        
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
        
        UIImage.cacheStorageCheck(at: validatedUrlString, completion: { (cachedImage) in
            
            guard cachedImage == nil else {
                decodedImage = cachedImage
                completion(decodedImage)
                return
            }
            
            let task = URLSession.shared.dataTask(with: validatedUrl) { (data, _, err) in
                
                DispatchQueue.main.async {
                    
                    if let err = err {
                        print(err)
                        completion(nil)
                        return
                    }
                    
                    guard let imageData = data else {
                        completion(nil)
                        print("Error: Could not convert response to Data")
                        return
                    }
                    
                    UIImage.cacheImage(with: validatedUrlString, data: imageData)
                    UIImage.cacheStorageCheck(at: validatedUrlString, completion: { (newCachedImage) in
                        if let unwrappedCachedImage = newCachedImage {
                            completion(unwrappedCachedImage)
                        } else {
                            completion(nil)
                        }
                    })
                }
            }
            
            task.resume()
        })
    }
    
    static let storage = Storage.storage()
    static func firebaseGetImage(reference: String, completion: @escaping (UIImage?) -> Void) {
        
        UIImage.cacheStorageCheck(at: reference, completion: { (cachedImage) in
            
            if let decodedImage = cachedImage {
                completion(decodedImage)
                return
            }
            
            storage.reference(withPath: reference).getData(maxSize: 1 * 1024 * 1024) { data, error in
                DispatchQueue.main.async {
                    if let error = error {
                        print(error)
                        completion(nil)
                        return
                    }
                    
                    guard let imageData = data else {
                        print("Error: Could not convert response to Data")
                        completion(nil)
                        return
                    }
                    
                    guard let image = UIImage(data: imageData) else {
                        print("Error: Could not convert data to image")
                        completion(nil)
                        return
                    }
                    
                    UIImage.cacheImage(with: reference, data: imageData)
                    completion(image)
                }
            }
        })
        
    }
}
