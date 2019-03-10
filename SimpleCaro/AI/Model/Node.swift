//
//  Node.swift
//  SimpleCaro
//
//  Created by Robert Nguyen on 3/11/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import Foundation

class Node {
    var move: Move
    var score: Int
    var isMax: Bool
    
    init(move: Move, score: Int, isMax: Bool) {
        self.move = move
        self.score = score
        self.isMax = isMax
    }
}
