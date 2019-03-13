//
//  AppPreferences.swift
//  SimpleCaro
//
//  Created by Robert Nguyen on 3/10/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import Foundation

struct AppPreferences {
    private let userDefault: UserDefaults
    
    static let instance = AppPreferences()
    
    enum Keys: String {
        case boardSize
        case difficulty
    }
    
    private init() {
        userDefault = UserDefaults.standard
        userDefault.register(defaults: [
            Keys.boardSize.rawValue: 30,
            Keys.difficulty.rawValue: 1
        ])
    }
    
    func get(key: Keys) -> Int {
        return userDefault.integer(forKey: key.rawValue)
    }
    
    func set(_ value: Int, forKey key: Keys) {
        userDefault.set(value, forKey: key.rawValue)
    }
}
