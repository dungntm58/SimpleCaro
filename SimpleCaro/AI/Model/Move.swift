//
//  Move.swift
//  SimpleCaro
//
//  Created by Robert Nguyen on 3/10/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import Foundation

struct Move {
    let sign: PlayerSign
    let coordinate: Coordinate
}

struct Coordinate {
    let row: Int
    let column: Int
}
