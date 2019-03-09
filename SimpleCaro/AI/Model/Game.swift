//
//  Game.swift
//  SimpleCaro
//
//  Created by Robert Nguyen on 3/10/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import Foundation

class GameController {
    private var playerIndex: Int = 0
    
    let board: Board
    let backupBoard: Board
    let players: [Player]
    
    var currentPlayer: Player {
        return players[playerIndex]
    }
    
    init(board: Board, players: [Player]) {
        self.board = board
        self.backupBoard = board
        self.players = players
    }
    
    func switchNextPlayer() {
        if playerIndex < players.count - 1 {
            playerIndex += 1
        }
        else {
            playerIndex = 0
        }
    }
    
    func makePlayerSign(at coorinate: Coordinate) -> Bool {
        return board.makeMove(Move(player: currentPlayer, coordinate: coorinate))
    }
}
