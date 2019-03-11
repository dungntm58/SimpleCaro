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
    
    func makeMove(on board: inout Board, from lastMove: Move?, difficulty: Int) throws -> Move {
        guard let lastMove = lastMove else {
            if board.isEmpty() {
                return Move(sign: sign, coordinate: Coordinate(row: board.size / 2, column: board.size / 2))
            }
            throw NSError(domain: "AI", code: 999, userInfo: [
                NSLocalizedDescriptionKey: "Invalid board"
            ])
        }
        
        var alpha = Int.min
        var beta = Int.max
        let node = Node(move: lastMove, score: 0, isMax: true)
        let result = alphaBeta(node: node, board: board, alpha: &alpha, beta: &beta, depth: 0, maxDepth: difficulty)
        
        board.place(sign: result.move.sign, at: result.move.coordinate)
        board.makeNearIndex(at: result.move.coordinate)
        return result.move
    }
    
    // Alpha beta
    func alphaBeta(node: Node, board: Board, alpha: inout Int, beta: inout Int, depth: Int, maxDepth: Int) -> Node {
        var _alpha = alpha
        var _beta = beta
        
        var resNode = node // nuoc di tot nhat se tra ve
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
            var maskBoard = board
            maskBoard.place(sign: move.sign, at: move.coordinate)
            maskBoard.makeNearIndex(at: move.coordinate)
            
            let oppositeNode = alphaBeta(node: Node(move: move, score: 0, isMax: !node.isMax), board: maskBoard, alpha: &_alpha, beta: &_beta, depth: depth + 1, maxDepth: maxDepth)
            
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
