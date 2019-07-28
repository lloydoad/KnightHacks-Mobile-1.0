//
//  ModelObserver.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/21/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

/**
 Observer pattern for notifying reciever of view model updates
 */
public protocol ModelObserver {
    func didFetchModel() -> Void
}
