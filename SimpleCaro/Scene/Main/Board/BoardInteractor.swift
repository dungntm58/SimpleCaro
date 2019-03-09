//
//  BoardInteractor.swift
//  SimpleCaro
//
//  Created by Robert Nguyen on 3/10/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import CoreCleanSwiftBase

class BoardInteractor: CleanInteractor {
    let presenter: BoardPresenter
    let worker: BoardWorker
    
    init(presenter: BoardPresenter) {
        self.presenter = presenter
        worker = BoardWorker()
    }
    
    
}
