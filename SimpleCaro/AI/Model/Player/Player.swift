//
//  Player.swift
//  SimpleCaro
//
//  Created by Robert Nguyen on 3/10/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import Foundation

enum PlayerSign: String {
    case x = "x"
    case o = "o"
    
    func toWinString() -> String {
        return Array(repeating: rawValue, count: 5).joined()
    }
}

protocol Player {
    var sign: PlayerSign { get }
    func move(on: Board)
}
