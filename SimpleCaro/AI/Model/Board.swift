//
//  Board.swift
//  SimpleCaro
//
//  Created by Robert Nguyen on 3/10/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import Foundation

class Board {
    var size: Int
    let numberOfContinuousSign: Int = 5
    var cells: [[Cell]]
    
    var lastMove: Move?
    
    init(size: Int) {
        self.size = size
        self.cells = Array(repeating: Array(repeating: Cell(), count: size), count: size)
    }
    
    init(other: Board){
        self.lastMove = other.lastMove
        self.size = other.size
        self.cells = []
        for i in 0...size-1 {
            let cellI = [Cell]()
            self.cells.append(cellI)
            for j in 0...self.size-1 {
                let cellJ = Cell(other: other.cells[i][j])
                self.cells[i].append(cellJ)
            }
        }
    }
    
    // Tao 1 nuoc di tren bang
    func makeMove(_ move: Move) -> Bool {
        let row = move.coordinate.row
        let col = move.coordinate.column
        
        if row >= size || row >= size || cell(at: move.coordinate).isPiece() {
            return false
        } else {
            cells[row][col].sign = move.player.sign
            return true
        }
    }
    
    func clearMove(at coordinate: Coordinate) {
        cells[coordinate.row][coordinate.column].sign = nil
    }
    
    func makeNearIndex(row: Int, col: Int){
        for i in -1...1 {
            if row + i < size && row + i >= 0 {
                for j in -1...1 {
                    if col + j < size && col + j >= 0 {
                        cells[row + i][col + j].nearIndex = 1
                    }
                }
            }
        }
    }
    
    // Function check empty
    func isEmpty() -> Bool {
        for row in 0...size - 1 {
            for col in 0...size - 1 {
                if self.cells[row][col].isPiece() {
                    return false
                }
            }
        }
        return true
    }
    
    // Function check full
    func isFull() -> Bool {
        for row in 0...size - 1 {
            for col in 0...size - 1 {
                if !self.cells[row][col].isPiece() {
                    return false
                }
            }
        }
        return true
    }
    
    func cell(at coordinate: Coordinate) -> Cell {
        return cells[coordinate.row][coordinate.column]
    }
    
    func checkWin(at coordinate: Coordinate) -> Bool {
        guard let sign = cells[coordinate.row][coordinate.column].sign else {
            return false
        }
        
        return checkVertical(of: sign, at: coordinate) ||
            checkHorizontal(of: sign, at: coordinate) ||
            checkCross(of: sign, at: coordinate) ||
            checkCross2(of: sign, at: coordinate)
    }
    
    // Function for check win
    func checkVertical(of sign: PlayerSign, at coordinate: Coordinate) -> Bool {
        //Check hang doc
        let row = coordinate.row
        let col = coordinate.column
        
        for i in -numberOfContinuousSign+1...numberOfContinuousSign-1 {
            if row + i >= 0 && row + i < size {
                
            }
        }
        return true
    }
    
    func checkHorizontal(of sign: PlayerSign, at coordinate: Coordinate) -> Bool {
        //Check hang ngang
        let row = coordinate.row
        let col = coordinate.column
        
        for i in -numberOfContinuousSign+1...numberOfContinuousSign-1 {
            if col + i >= 0 && col + i < size {
                
            }
        }
        return true
    }
    
    func checkCross(of sign: PlayerSign, at coordinate: Coordinate) -> Bool {
        //Check hang cheo "/"
        let row = coordinate.row
        let col = coordinate.column
        
        for i in -numberOfContinuousSign+1...numberOfContinuousSign-1 {
            if (row + i) >= 0 && (row + i) < size && (col + i) >= 0 && (col + i) < size {
                
            }
        }
        return true
    }
    
    func checkCross2(of sign: PlayerSign, at coordinate: Coordinate) -> Bool {
        //Check hang cheo "\"
        let row = coordinate.row
        let col = coordinate.column
        
        for i in -numberOfContinuousSign+1...numberOfContinuousSign-1 {
            if row + i >= 0 && row + i < size && col - i >= 0 && col - i < size {
                
            }
        }
        return true
    }
    
    func copy(other: Board) -> Bool {
        if self.size != other.size {
            print("copy board fail")
            return false
        }
        for row in 0..<size {
            for col in 0..<size {
                self.cells[row][col] = other.cells[row][col]
            }
        }
        self.lastMove = other.lastMove
        return true
    }
    
    // For test. Use in BoardViewController
    func printBoard(){
        for i in 0...size - 1 {
            for j in 0...size - 1 {
                if cells[i][j].isPiece() {
                    print(cells[i][j].sign!, terminator: " ")
                } else {
                    print(cells[i][j].nearIndex, terminator: " ")
                }
            }
            print("\n")
        }
        print("End")
    }
}
