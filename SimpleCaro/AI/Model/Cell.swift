//
//  Cell.swift
//  SimpleCaro
//
//  Created by Robert Nguyen on 3/10/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import Foundation

class Cell {
    var sign: PlayerSign?
    var nearIndex: Int = 0
    
    init() {}
    
    init(other: Cell) {
        self.sign = other.sign
    }
    
    func isPiece() -> Bool {
        return sign != nil
    }
}
