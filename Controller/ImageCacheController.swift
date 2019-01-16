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
    
    static func cacheStorageCheck(at url: String!, imageData: Data?, completion: @escaping (UIImage?) -> ()) {
        if let cachedImage = imageCache.object(forKey: url as AnyObject) as? Data {
            print("image is in cache")
            completion(UIImage(data: cachedImage))
            return
        }
        
        imageCache.setObject(imageData as AnyObject, forKey: url as AnyObject)
        completion(nil)
    }
}
