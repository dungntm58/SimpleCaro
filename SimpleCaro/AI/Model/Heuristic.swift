//
//  Heuristic.swift
//  SimpleCaro
//
//  Created by Robert Nguyen on 3/10/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import Foundation

struct ThreatState {
    let state: String
    let score: Int
    
    static let initialState: [ThreatState] = {
        return [
            ThreatState(state: "11111", score: 10000000), //da thang
            ThreatState(state: "011110", score: 1000000),  // gan nhu chac chan thang
            //bat buoc phai chan
            ThreatState(state: "211110", score: 80000),
            ThreatState(state: "011112", score: 80000),
            ThreatState(state: "211101", score: 50000),
            ThreatState(state: "101112", score: 50000),
            ThreatState(state: "11011", score: 30000),
            ThreatState(state: "01110", score: 30000),
            ThreatState(state: "010110", score: 30000),
            ThreatState(state: "011010", score: 30000),
            ThreatState(state: "11101", score: 28000),
            ThreatState(state: "10111", score: 28000),
            //nguy hiem
            ThreatState(state: "211100", score: 1000),
            ThreatState(state: "001112", score: 1000),
            ThreatState(state: "211010", score: 800),
            ThreatState(state: "010112", score: 800),
            ThreatState(state: "210110", score: 300),
            ThreatState(state: "011012", score: 300),
            ThreatState(state: "10101", score: 100),
            ThreatState(state: "01100", score: 30),
            ThreatState(state: "00110", score: 30),
            ThreatState(state: "01010", score: 10),
            ThreatState(state: "01000", score: 2),
            ThreatState(state: "00100", score: 2),
            ThreatState(state: "00010", score: 2)
        ]
    }()
    
    static let initialStateForOneDepth: [ThreatState] = {
        return [
            ThreatState(state: "11111", score: 10000000), //da thang
            ThreatState(state: "011110", score: 80000),  // gan nhu chac chan thang
            //bat buoc phai chan
            ThreatState(state: "211110", score: 80000),
            ThreatState(state: "011112", score: 80000),
            ThreatState(state: "211101", score: 50000),
            ThreatState(state: "101112", score: 50000),
            ThreatState(state: "11011", score: 30000),
            ThreatState(state: "01110", score: 30000),
            ThreatState(state: "010110", score: 30000),
            ThreatState(state: "011010", score: 30000),
            ThreatState(state: "11101", score: 28000),
            ThreatState(state: "10111", score: 28000),
            //nguy hiem
            ThreatState(state: "211100", score: 15),
            ThreatState(state: "001112", score: 15),
            ThreatState(state: "211010", score: 15),
            ThreatState(state: "010112", score: 15),
            ThreatState(state: "210110", score: 15),
            ThreatState(state: "011012", score: 15),
            ThreatState(state: "10101", score: 40),
            ThreatState(state: "01100", score: 40),
            ThreatState(state: "00110", score: 40),
            ThreatState(state: "01010", score: 20),
            ThreatState(state: "01000", score: 2),
            ThreatState(state: "00100", score: 2),
            ThreatState(state: "00010", score: 2)
        ]
    }()
}
