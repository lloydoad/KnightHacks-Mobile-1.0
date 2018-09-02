//
//  Buttons.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 8/29/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

struct FilterButton {
    var name: String
    var image: UIImage {
        if let img = UIImage(named: "\(self.name.lowercased()) filter icon")  {
            return img
        } else {
            return UIImage()
        }
    }
    
    init(name: String) {
        self.name = name
    }
}

struct MenuButton {
    var name: String
    var color: UIColor
    var icon: UIImage {
        if let img = UIImage(named: (self.name.lowercased()))  {
            return img
        } else {
            return UIImage()
        }
    }
    
    init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
}
