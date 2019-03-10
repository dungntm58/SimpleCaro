//
//  MainInteractor.swift
//  SimpleCaro
//
//  Created by Robert Nguyen on 3/9/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import CoreCleanSwiftBase

class MainInteractor: CleanInteractor {
    
    enum GameOptions {
        case humanFirst
        case botFirst
        case manually
    }
    
    let presenter: MainPresenter
    let boardPresenter: BoardPresenter
    var options: GameOptions
    var gameController: GameController!
    
    init(presenter: MainPresenter, boardPresenter: BoardPresenter) {
        self.presenter = presenter
        self.boardPresenter = boardPresenter
        self.options = .humanFirst
    }
    
    var boardSize: Int {
        set {
            AppPreferences.instance.set(newValue, forKey: .boardSize)
        }
        get {
            return AppPreferences.instance.get(key: .boardSize)
        }
    }
    
    var difficulty: Int {
        set {
            AppPreferences.instance.set(newValue, forKey: .difficulty)
        }
        get {
            return AppPreferences.instance.get(key: .difficulty)
        }
    }
    
    func startGame() {
        let players: [Player]
        
        switch options {
        case .humanFirst:
            players = [Human(sign: .x), Bot(sign: .o)]
        case .botFirst:
            players = [Bot(sign: .x), Human(sign: .o)]
        case .manually:
            players = [Human(sign: .x), Human(sign: .o)]
        }
        gameController = GameController(boardSize: boardSize, difficulty: difficulty, players: players)
        gameController.start()
    }
    
    func place(at coordinate: Coordinate) {
        _ = gameController.makePlayerSign(at: coordinate)
    }
}
