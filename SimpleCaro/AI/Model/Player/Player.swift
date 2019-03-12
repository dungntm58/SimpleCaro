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
    
    func toOppositeSign() -> PlayerSign {
        switch self {
        case .x:
            return .o
        case .o:
            return .x
        }
    }
}

protocol Player {
    var sign: PlayerSign { get }
}

protocol AI {
    var operationQueue: DispatchQueue { get }
    func makeMove(on board: Board, from lastMove: Move?, difficulty: Int, completion: @escaping (Move) -> Void) throws
}
