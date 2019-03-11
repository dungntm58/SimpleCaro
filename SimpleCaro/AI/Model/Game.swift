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
    
    private var board: Board
    private let players: [Player]
    private let difficulty: Int
    
    private(set) var moves: [Move]
    
    var currentPlayer: Player {
        return players[playerIndex]
    }
    
    init(boardSize: Int, difficulty: Int, players: [Player], numberOfContinuousSign: Int = 5) {
        self.board = Board(size: boardSize, numberOfContinuousSign: numberOfContinuousSign)
        self.difficulty = difficulty
        self.players = players
        self.moves = []
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
        let move = Move(sign: currentPlayer.sign, coordinate: coorinate)
        let success = board.place(sign: move.sign, at: coorinate)
        if success {
            self.moves.append(move)
        }
        return success
    }
    
    func undo() {
        guard let lastMove = moves.popLast() else { return }
        board.clearMove(at: lastMove.coordinate)
    }
    
    func start() {
        
    }
    
    func checkWin(at coordinate: Coordinate) -> Bool {
        return board.checkWin(at: coordinate)
    }
    
    func printDebug() {
        #if DEBUG
        board.printBoard()
        #endif
    }
}
