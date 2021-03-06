//
//  MainView.swift
//  SimpleCaro
//
//  Created by Robert Nguyen on 3/10/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import CoreCleanSwiftBase

protocol MainView: CleanDisplayable {
    func showGameOver(msg: String)
}
