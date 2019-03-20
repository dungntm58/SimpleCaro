//
//  BoardModel.swift
//  SimpleCaro
//
//  Created by Robert Nguyen on 3/10/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import CoreCleanSwiftBase
import DifferenceKit

struct BoardViewModel {
    struct Cell: CleanListViewModel, Differentiable {
        typealias DifferenceIdentifier = Int
        
        func isContentEqual(to source: BoardViewModel.Cell) -> Bool {
            return isNew == source.isNew
        }
        
        let differenceIdentifier: Int
        let sign: PlayerSign?
        let isNew: Bool
    }
}
