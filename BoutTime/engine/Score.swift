//
//  Score.swift
//  BoutTime
//
//  Created by PrevoleTraining on 15.12.17.
//  Copyright © 2017 PrevoleTraining. All rights reserved.
//

/**
 Implementation of a score
 */
class Score: Scorable {
    let scoreMax: Int
    let score: Int
    
    /**
     Constructor
 
     - parameter score: The player score in the game
     - parameter scoreMax: The score max the current game
     */
    init(score: Int, scoreMax: Int) {
        self.scoreMax = scoreMax
        self.score = score
    }
}
