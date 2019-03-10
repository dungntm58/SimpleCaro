//
//  Board.swift
//  SimpleCaro
//
//  Created by Robert Nguyen on 3/10/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import Foundation

struct Board {
    let size: Int
    private let numberOfContinuousSign: Int
    private var cells: [[Cell]]
    
    init(size: Int, numberOfContinuousSign: Int) {
        self.size = size
        self.numberOfContinuousSign = numberOfContinuousSign
        self.cells = Array(repeating: Array(repeating: Cell(), count: size), count: size)
    }
    
    @discardableResult
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
    
    func heuristic(sign: PlayerSign, maxDepth: Int) -> Int {
        var result = 0
        var threats: [ThreatState]!
        
        if maxDepth == 1 {
            threats = ThreatState.initialStateForOneDepth
        } else {
            threats = ThreatState.initialState
        }
        //Tao mot mang mat na
        var maskBoard: [[Int]] = []
        for row in 0..<size {
            var rows: [Int] = [Int]()
            for col in 0..<size {
                if cells[row][col].isPlaced {
                    let temInt = (cells[row][col].sign == sign) ? 1 : 2
                    rows.append(temInt)
                } else {
                    rows.append(0)
                }
            }
            maskBoard.append(rows)
        }
        
        //Duyet cac hang ngang
        for row in 0..<size {
            var rowString = String()
            rowString.append("2")
            for col in 0..<size {
                rowString.append(String(maskBoard[row][col]))
            }
            rowString.append("2")
            // Tinh diem
            for threat in threats {
                var temRowString = rowString
                while let range = temRowString.range(of: threat.state) {
                    result += threat.score
                    temRowString = String(temRowString[range.upperBound...])
                }
            }
        }
        
        //Duyet cac hang doc
        for col in 0..<size {
            // Lay cot vao colString
            var colString = String()
            colString.append("2")
            for row in 0..<size {
                colString.append(String(maskBoard[row][col]))
            }
            colString.append("2")
            // Tinh diem
            for threat in threats {
                var temColString = colString
                while let range = temColString.range(of: threat.state) {
                    result += threat.score
                    temColString = String(temColString[range.upperBound...])
                }
            }
        }
        
        //Duyet duong cheo /
        for sum in 0..<2*size - 1 {
            var crossString = String()
            crossString.append("2")
            var limit = 0;
            if sum >= size {
                limit = sum - size + 1
            }
            
            for row in limit..<size {
                if sum >= row {
                    crossString.append(String(maskBoard[row][sum - row]))
                }
            }
            crossString.append("2")
            //Tinh diem
            for threat in threats {
                var temCrossString = crossString
                while let range = temCrossString.range(of: threat.state) {
                    result += threat.score
                    temCrossString = String(temCrossString[range.upperBound...])
                }
            }
        }
        
        //Duyet duong cheo \
        for subtraction in (-size + 1)...(size - 1) {
            var crossString = String()
            crossString.append("2")
            var limit = 0;
            if subtraction > 0 {
                limit = subtraction
            }
            for row in limit..<size {
                if row >= subtraction && row - subtraction < size {
                    crossString.append(String(maskBoard[row][row - subtraction]))
                }
            }
            crossString.append("2")
            //Tinh diem
            for threat in threats {
                var temCrossString = crossString
                while let range = temCrossString.range(of: threat.state) {
                    result += threat.score
                    temCrossString = String(temCrossString[range.upperBound...])
                }
            }
        }
        return result
    }
    
    func genMoves(playerSign: PlayerSign) -> [Move] {
        var nearestMove: [Move] = []
        
        for i in 0..<size {
            for j in 0..<size {
                if !cells[i][j].isPlaced && cells[i][j].nearIndex == 1 {
                    nearestMove.append(Move(sign: playerSign, coordinate: Coordinate(row: i, column: j)))
                }
            }
        }
        
        return nearestMove
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
