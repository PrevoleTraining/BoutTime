//
//  Scorable.swift
//  BoutTime
//
//  Created by PrevoleTraining on 15.12.17.
//  Copyright © 2017 PrevoleTraining. All rights reserved.
//

/**
 Represent the score and the maximum score possible in a single game
 */
protocol Scorable {
    var scoreMax: Int { get }
    var score: Int { get }
}
