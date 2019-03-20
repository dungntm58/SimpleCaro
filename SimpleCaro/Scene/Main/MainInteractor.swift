//
//  MainInteractor.swift
//  SimpleCaro
//
//  Created by Robert Nguyen on 3/9/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import CoreCleanSwiftBase

class MainInteractor: CleanInteractor {
    
    enum GameOptions: Int {
        case humanFirst = 0
        case botFirst = 1
        case manually = 2
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
        gameController.delegate = self
        gameController.start()
        boardPresenter.presentBoard(size: boardSize)
    }
    
    func place(at coordinate: Coordinate) {
        gameController.makeMoveManually(at: coordinate)
    }
    
    var heuristic: Int {
        return gameController.heuristic
    }
}

extension MainInteractor: GameControllerDelegate {
    func moveError(_ error: Error) {
        DispatchQueue.main.async {
            [weak self] in
            self?.presenter.onError(error)
        }
    }
    
    func moveSuccess(move: Move) {
        gameController.switchNextPlayer()
        gameController.makeMoveAutoIfPossible()
        DispatchQueue.main.async {
            [weak self] in
            guard let `self` = self else { return }
            self.boardPresenter.presentUpdate(at: move.coordinate, sign: move.sign, boardSize: self.boardSize)
            if let sign = self.gameController.checkWin(at: move.coordinate), let player = self.gameController.player(of: sign) {
                self.presenter.presentGameOver(player: player)
            }
        }
    }
}
