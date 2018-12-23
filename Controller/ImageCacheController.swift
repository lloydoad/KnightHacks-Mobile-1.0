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
    
    static func cacheStorageCheck(at url: Data, completion: @escaping (UIImage?) -> Void?) {
        
        if let cachedImage = imageCache.object(forKey: url as AnyObject) as? UIImage {
            print("image was already cached")
            completion(cachedImage)
        } else {
            imageCache.setObject(UIImage(data: url)!, forKey: url as AnyObject)
        }
        completion(nil)
    }
} 
