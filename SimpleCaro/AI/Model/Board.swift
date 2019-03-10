//
//  Board.swift
//  SimpleCaro
//
//  Created by Robert Nguyen on 3/10/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import Foundation

struct Board {
    private let size: Int
    private let numberOfContinuousSign: Int
    private var cells: [[Cell]]
    
    init(size: Int, numberOfContinuousSign: Int) {
        self.size = size
        self.numberOfContinuousSign = numberOfContinuousSign
        self.cells = Array(repeating: Array(repeating: Cell(), count: size), count: size)
    }
    
    func place(sign: PlayerSign, at coordinate: Coordinate) -> Bool {
        let row = coordinate.row
        let col = coordinate.column
        
        if row >= size || row >= size || cell(at: coordinate).isPlaced {
            return false
        } else {
            cells[row][col].sign = sign
            return true
        }
    }
    
    func clearMove(at coordinate: Coordinate) {
        cell(at: coordinate).sign = nil
    }
    
    func makeNearIndex(at coordinate: Coordinate) {
        let row = coordinate.row
        let col = coordinate.column
        
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
        for row in 0..<size {
            for col in 0..<size {
                if cells[row][col].isPlaced {
                    return false
                }
            }
        }
        return true
    }
    
    // Function check full
    func isFull() -> Bool {
        for row in 0..<size {
            for col in 0..<size {
                if !cells[row][col].isPlaced {
                    return false
                }
            }
        }
        return true
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
    
    // For test. Use in BoardViewController
    func printBoard() {
        for i in 0...size - 1 {
            for j in 0...size - 1 {
                if let sign = cells[i][j].sign {
                    print(sign.rawValue, terminator: " ")
                } else {
                    print(cells[i][j].nearIndex, terminator: " ")
                }
            }
            print("\n")
        }
        print("End")
    }
}

private extension Board {
    func cell(at coordinate: Coordinate) -> Cell {
        return cells[coordinate.row][coordinate.column]
    }
    
    func checkVertical(of sign: PlayerSign, at coordinate: Coordinate) -> Bool {
        let row = coordinate.row
        let col = coordinate.column
        
        for i in -numberOfContinuousSign+1...numberOfContinuousSign-1 {
            if row + i >= 0 && row + i < size {
                
            }
        }
        return true
    }
    
    func checkHorizontal(of sign: PlayerSign, at coordinate: Coordinate) -> Bool {
        let row = coordinate.row
        let col = coordinate.column
        
        for i in -numberOfContinuousSign+1...numberOfContinuousSign-1 {
            if col + i >= 0 && col + i < size {
                
            }
        }
        return true
    }
    
    func checkCross(of sign: PlayerSign, at coordinate: Coordinate) -> Bool {
        let row = coordinate.row
        let col = coordinate.column
        
        for i in -numberOfContinuousSign+1...numberOfContinuousSign-1 {
            if row + i >= 0 && row + i < size && col + i >= 0 && col + i < size {
                
            }
        }
        return true
    }
    
    func checkCross2(of sign: PlayerSign, at coordinate: Coordinate) -> Bool {
        let row = coordinate.row
        let col = coordinate.column
        
        for i in -numberOfContinuousSign+1...numberOfContinuousSign-1 {
            if row + i >= 0 && row + i < size && col - i >= 0 && col - i < size {
                
            }
        }
        return true
    }
}
