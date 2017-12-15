//
//  Score.swift
//  BoutTime
//
//  Created by lprevost on 15.12.17.
//  Copyright © 2017 prevole.ch. All rights reserved.
//

class Score: Scorable {
    let scoreMax: Int
    let score: Int
    
    init(score: Int, scoreMax: Int) {
        self.scoreMax = scoreMax
        self.score = score
    }
}
