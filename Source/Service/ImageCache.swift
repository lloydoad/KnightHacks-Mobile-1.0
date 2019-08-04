//
//  ImageCache.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 8/3/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

private let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImage {
    
    static func cacheStorageCheck(at url: String!, imageData: Data?, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: url as AnyObject) as? Data {
            completion(UIImage(data: cachedImage))
            return
        }
        
        imageCache.setObject(imageData as AnyObject, forKey: url as AnyObject)
        completion(nil)
    }
}
