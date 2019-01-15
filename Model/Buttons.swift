//
//  Buttons.swift
//  KnightHacks
//
//  Created by KnightHacks on 8/29/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

struct FilterButton {
    var name: String
    var type: Filter
    var image: UIImage {
        if let img = UIImage(named: "\(self.name.lowercased()) filter icon")  {
            return img
        } else {
            return UIImage()
        }
    }
    
    init(input: Filter) {
        self.type = input
        self.name = input.rawValue
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
