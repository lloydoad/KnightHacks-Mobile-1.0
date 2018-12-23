//
//  ImageCache.swift
//  KnightHacks
//
//  Created by KnightHacks on 11/6/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImage {
    
    static func cacheStorageCheck(at url: String!, completion: @escaping (UIImage?) -> ()) {
        
        if let cachedImage = imageCache.object(forKey: url as AnyObject) as? UIImage {
            print("image was already cached")
            completion(cachedImage)
            return
        }

        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if (error != nil) {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: url as AnyObject)
                    print("image was not cached, but now it is")
                    completion(downloadedImage)
                }
            }
        }
        task.resume()
    }
} 
