//
//  BoardView.swift
//  SimpleCaro
//
//  Created by Robert Nguyen on 3/10/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import Foundation

protocol BoardView: class {
    func showGrid(size: Int)
    func updateCell(at coordinate: Coordinate, sign: PlayerSign)
}
