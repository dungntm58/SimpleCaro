//
//  Game.swift
//  SimpleCaro
//
//  Created by Robert Nguyen on 3/10/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import Foundation

protocol GameControllerDelegate: class {
    func moveError(_ error: Error)
    func moveSuccess(move: Move)
}

enum GameError: Error {
    case busy
    
    var localizedDescription: String {
        switch self {
        case .busy:
            return "Game is busy now"
        }
    }
}

class GameController {
    private var playerIndex: Int = 0
    
    private var board: Board
    private let players: [Player]
    private let difficulty: Int
    private(set) var isThinking: Bool
    
    weak var delegate: GameControllerDelegate?
    
    private(set) var moves: [Move]
    
    var currentPlayer: Player {
        return players[playerIndex]
    }
    
    init(boardSize: Int, difficulty: Int, players: [Player], numberOfContinuousSign: Int = 5) {
        self.board = Board(size: boardSize, numberOfContinuousSign: numberOfContinuousSign)
        self.difficulty = difficulty
        self.players = players
        self.moves = []
        self.isThinking = false
    }
    
    func switchNextPlayer() {
        if playerIndex < players.count - 1 {
            playerIndex += 1
        }
        else {
            playerIndex = 0
        }
    }
    
    func undo() {
        guard let lastMove = moves.popLast() else { return }
        board.clearMove(at: lastMove.coordinate)
    }
    
    func start() {
        makeMoveAutoIfPossible()
    }
    
    func makeMoveAutoIfPossible() {
        if let ai = currentPlayer as? AI {
            do {
                if isThinking {
                    delegate?.moveError(GameError.busy)
                    return
                }
                
                isThinking = true
                try ai.makeMove(on: board, from: moves.last, difficulty: difficulty) {
                    move in
                    do {
                        try self.board.place(sign: move.sign, at: move.coordinate)
                        self.isThinking = false
                        self.delegate?.moveSuccess(move: move)
                    }
                    catch {
                        self.isThinking = false
                        self.delegate?.moveError(error)
                    }
                }
            }
            catch {
                isThinking = false
                delegate?.moveError(error)
            }
        }
    }
    
    func makeMoveManually(at coordinate: Coordinate) {
        if isThinking {
            delegate?.moveError(GameError.busy)
            return
        }
        
        isThinking = true
        let move = Move(sign: currentPlayer.sign, coordinate: coordinate)
        do {
            try board.place(sign: move.sign, at: coordinate)
            moves.append(move)
            isThinking = false
            delegate?.moveSuccess(move: move)
        }
        catch {
            isThinking = false
            delegate?.moveError(error)
        }
    }
    
    func checkWin(at coordinate: Coordinate) -> PlayerSign? {
        if board.checkWin(at: coordinate) {
            return board.cell(at: coordinate).sign
        }
        
        return nil
    }
    
    var heuristic: Int {
        return players.map { $0.sign }.map { board.heuristic(sign: $0, maxDepth: difficulty) }.reduce(0) { $0 + $1 }
    }
    
    func player(of sign: PlayerSign) -> Player? {
        return players.first(where: { $0.sign == sign })
    }
    
    func printDebug() {
        #if DEBUG
        board.printBoard()
        #endif
    }
}
