//
//  Gamable.swift
//  BoutTime
//
//  Created by PrevoleTraining on 15.12.17.
//  Copyright © 2017 PrevoleTraining. All rights reserved.
//

/**
 Manage a game
 */
protocol Gamable {
    /**
     Constructor
 
     - parameter numberOfRounds: The number of rounds to play in a single game
     - parameter eventsPerRound: The number of events to sort in a single round
     - parameter eventProvider: The event provider to pick the events
     */
    init(numberOfRounds: Int, eventsPerRound: Int, eventProvider: EventProvidable)
    
    /**
     Restore the game in a a valid state to play a game
     
     - return The collection of unsorted events for the first round
     */
    func newGame() -> [Event]
    
    /**
     Evalute the current events.
     
     - return The result of evaluation
     */
    func evaluate() -> EvaluationResult
    
    /**
     Verifies if it remains at least one round to play
     
     - return True if there is one or more rounds to play
     */
    func hasNextRound() -> Bool
    
    /**
     Prepare the game to handle the next round
     
     - return The collection of unsorted events for the next round
     */
    func nextRound() -> [Event]
    
    /**
     Permute two events
     
     - parameter firstEvent: Index of the first event
     - parameter secondEvent: Index of the second event
     
     - return The current collection of events
     */
    func permute(firstEvent left: Int, secondEvent right: Int) -> [Event]
    
    /**
     Calculate the score of the game
     
     - return The score
     */
    func score() -> Scorable
    
    /**
     Retrieve the solution for the current game
     
     - return The events in ascending order
     */
    func retrieveSolution() -> [Event]
}
