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
    private var numberOfPlacedCells: Int
    private var cells: [[Cell]]
    
    fileprivate let winString: String
    
    init(size: Int, numberOfContinuousSign: Int) {
        self.size = size
        self.numberOfContinuousSign = numberOfContinuousSign
        self.cells = Array(repeating: Array(repeating: Cell(), count: size), count: size)
        self.numberOfPlacedCells = 0
        self.winString = String(repeating: "0", count: numberOfContinuousSign)
    }
    
    @discardableResult
    mutating func place(sign: PlayerSign, at coordinate: Coordinate) -> Bool {
        let row = coordinate.row
        let col = coordinate.column
        
        if row >= size || row >= size || cell(at: coordinate).isPlaced {
            return false
        } else {
            cells[row][col].sign = sign
            numberOfPlacedCells += 1
            return true
        }
    }
    
    mutating func clearMove(at coordinate: Coordinate) {
        cells[coordinate.row][coordinate.column].sign = nil
        numberOfPlacedCells -= 1
    }
    
    mutating func makeNearIndex(at coordinate: Coordinate) {
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
        return numberOfPlacedCells == 0
    }
    
    // Function check full
    func isFull() -> Bool {
        return numberOfPlacedCells == size * size
    }
    
    func checkWin(at coordinate: Coordinate) -> Bool {
        guard let sign = cells[coordinate.row][coordinate.column].sign else {
            return false
        }
        
        return checkWinVertical(of: sign, at: coordinate) ||
            checkWinHorizontal(of: sign, at: coordinate) ||
            checkWinCross(of: sign, at: coordinate) ||
            checkWinCross2(of: sign, at: coordinate)
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
        
        let sizeRange = (0..<size).map { Int($0) }
        let maskBoard: [[Int]] = sizeRange.map {
            row in
            let rowCells = cells[row]
            return sizeRange.map {
                col in
                switch rowCells[col].sign {
                case .none:
                    return 0
                case .some(let value):
                    if value == sign {
                        return 1
                    }
                    return 2
                }
            }
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
                if cells[i][j].isEmpty && cells[i][j].nearIndex == 1 {
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
    
    func toMapSign(_ cell: Cell, ofSign sign: PlayerSign) -> String {
        guard let cSign = cell.sign else {
            return " "
        }
        if sign == cSign {
            return "0"
        }
        return "1"
    }
    
    func checkWinVertical(of sign: PlayerSign, at coordinate: Coordinate) -> Bool {
        let row = coordinate.row
        let colCells = cells[coordinate.column]
        let start = max(row - numberOfContinuousSign + 1, 0)
        let end = min(row + numberOfContinuousSign - 1, size)
        if end - start + 1 < numberOfContinuousSign {
            return false
        }
        
        let test = (start...end)
            .map { Int($0) }
            .map { colCells[$0] }
            .map { toMapSign($0, ofSign: sign) }
        return test.contains(winString)
    }
    
    func checkWinHorizontal(of sign: PlayerSign, at coordinate: Coordinate) -> Bool {
        let col = coordinate.column
        let start = max(col - numberOfContinuousSign + 1, 0)
        let end = min(col + numberOfContinuousSign - 1, size)
        if end - start + 1 < numberOfContinuousSign {
            return false
        }
        
        let test = (start...end)
            .map { Int($0) }
            .map { cells[coordinate.row][$0] }
            .map { toMapSign($0, ofSign: sign) }
        return test.contains(winString)
    }
    
    func checkWinCross(of sign: PlayerSign, at coordinate: Coordinate) -> Bool {
        let row = coordinate.row
        let col = coordinate.column
        
        let startRow = max(row - numberOfContinuousSign + 1, 0)
        let endRow = min(row + numberOfContinuousSign - 1, size)
        let startCol = max(col - numberOfContinuousSign + 1, 0)
        let endCol = min(col + numberOfContinuousSign - 1, size)
        
        let start = min(startRow, startCol)
        let end = max(endRow, endCol)
        
        if end - start + 1 < numberOfContinuousSign {
            return false
        }
        
        let test = (start...end)
            .map { Int($0) }
            .map { cells[$0][$0] }
            .map { toMapSign($0, ofSign: sign) }
        return test.contains(winString)
    }
    
    func checkWinCross2(of sign: PlayerSign, at coordinate: Coordinate) -> Bool {
        let row = coordinate.row
        let col = coordinate.column
        
        let startRow = max(row - numberOfContinuousSign + 1, 0)
        let endRow = min(row + numberOfContinuousSign - 1, size)
        let startCol = max(col - numberOfContinuousSign + 1, 0)
        let endCol = min(col + numberOfContinuousSign - 1, size)
        
        let start = min(startRow, startCol)
        let end = max(endRow, endCol)
        
        if end - start + 1 < numberOfContinuousSign {
            return false
        }
        
        let sum = start + end
        let test = (start...end)
            .map { Int($0) }
            .map {
                col -> Cell in
                let row = sum - col
                return cells[row][col]
            }
            .map { toMapSign($0, ofSign: sign) }
        return test.contains(winString)
    }
}
