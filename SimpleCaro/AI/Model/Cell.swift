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
    var nearIndex: Int
    
    init() {
        self.nearIndex = 0
    }
    
    var isPlaced: Bool {
        return sign != nil
    }
}
