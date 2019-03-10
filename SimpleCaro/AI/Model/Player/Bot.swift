//
//  Bot.swift
//  SimpleCaro
//
//  Created by Robert Nguyen on 3/10/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import Foundation

struct Bot: Player, AI {
    let sign: PlayerSign
    
    func makeMove(on board: inout Board, from lastMove: Move?) -> Move {
        let move: Move
        if board.isEmpty() {
            move = Move(sign: sign, coordinate: Coordinate(row: board.size / 2, column: board.size / 2))
        } else {
            var alpha = -1_000_000_000
            var beta = 1_000_000_000
            let node = Node(move: lastMove!, score: 0, isMax: true)
            var maskBoard = board
            let result = alphaBeta(node: node, board: &maskBoard, alpha: &alpha, beta: &beta, depth: 0, maxDepth: AppPreferences.instance.get(key: .difficulty))
            
            board.place(sign: result.move.sign, at: result.move.coordinate)
            board.makeNearIndex(at: result.move.coordinate)
            move = result.move
        }
        return move
    }
    
    // Alpha beta
    func alphaBeta(node: Node, board: inout Board, alpha: inout Int, beta: inout Int, depth: Int, maxDepth: Int) -> Node {
        var _alpha = alpha
        var _beta = beta
        
        let resNode = node // nuoc di tot nhat se tra ve
        // Neu la nut la tra ve node vua di
        if board.isFull() || board.checkWin(at: node.move.coordinate) || depth >= maxDepth {
            resNode.score = sumHeuristic(board: board, maxDepth: maxDepth)
            return resNode
        }
        
        // Set gia tri alpha, beta
        if node.isMax {
            resNode.score = _alpha
        } else {
            resNode.score = _beta
        }
        
        // Sinh cac nuoc di
        let movesArray = board.genMoves(playerSign: node.move.sign.toOppositeSign())
        for move in movesArray {
            let backupBoard = board
            board.place(sign: move.sign, at: move.coordinate)
            board.makeNearIndex(at: move.coordinate)
            
            let oppositeNode = alphaBeta(node: Node(move: move, score: 0, isMax: !node.isMax), board: &board, alpha: &_alpha, beta: &_beta, depth: depth + 1, maxDepth: maxDepth)
            
            // Restore board
            board = backupBoard
            
            if node.isMax && oppositeNode.score > resNode.score {
                resNode.move = move
                resNode.score = oppositeNode.score
                _alpha = oppositeNode.score
            } else if !node.isMax && oppositeNode.score < resNode.score {
                resNode.move = move
                resNode.score = oppositeNode.score
                _beta = oppositeNode.score
            }
            
            if _alpha >= _beta {
                return resNode
            }
        }
        return resNode
    }
    
    // ham danh gia
    func sumHeuristic(board: Board, maxDepth: Int) -> Int {
            return board.heuristic(sign: sign, maxDepth: maxDepth) - board.heuristic(sign: sign.toOppositeSign(), maxDepth: maxDepth)
    }
}
