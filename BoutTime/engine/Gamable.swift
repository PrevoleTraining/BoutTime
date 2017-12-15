//
//  Gamable.swift
//  BoutTime
//
//  Created by lprevost on 15.12.17.
//  Copyright © 2017 prevole.ch. All rights reserved.
//

protocol Gamable {
    init(numberOfRounds: Int, eventsPerRound: Int, eventProvider: EventProvidable)
    
    func newGame() -> [EventDescriptable]
    func evaluate() -> EvaluationResult
    func hasNextRound() -> Bool
    func nextRound() -> [EventDescriptable]
    func permute(firstEvent left: Int, secondEvent right: Int)
    func score() -> Scorable
}
