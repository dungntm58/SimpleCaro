//
//  BoardPresenter.swift
//  SimpleCaro
//
//  Created by Robert Nguyen on 3/10/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import CoreCleanSwiftBase

struct BoardPresenter: CleanInteractor {
    weak var view: BoardView?
    
    func presentBoard(size: Int) {
        view?.showGrid(size: size)
    }
    
    func presentUpdate(at coordinate: Coordinate, sign: PlayerSign) {
        view?.updateCell(at: coordinate, sign: sign)
    }
}
