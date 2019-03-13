//
//  MainPresenter.swift
//  SimpleCaro
//
//  Created by Robert Nguyen on 3/10/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import CoreCleanSwiftBase

class MainPresenter: CleanPresenter {
    private weak var view: MainView?
    
    init(view: MainView) {
        self.view = view
    }
    
    func presentGameOver(player: Player) {
        view?.showGameOver(msg: "Player \(type(of: player)) wins")
    }
    
    func onError(_ error: Error) {
        self.view?.onError(error)
    }
}
