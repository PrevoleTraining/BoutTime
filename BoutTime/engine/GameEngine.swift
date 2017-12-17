//
//  GameEngine.swift
//  BoutTime
//
//  Created by PrevoleTraining on 15.12.17.
//  Copyright © 2017 PrevoleTraining. All rights reserved.
//

/**
 Game engine
 */
class GameEngine: Gamable {
    let numberOfRounds: Int
    let eventsPerRound: Int
    
    // The service to get the events randomly
    let eventProvider: EventProvidable
    
    // Keep track of round evaluations
    var evaluations: [EvaluationResult] = []
    
    // The events to be ordered
    var currentEvents: [Eventable] = []
    
    // The events ordered
    var solution: [Eventable] = []
    
    required init(numberOfRounds: Int, eventsPerRound: Int, eventProvider: EventProvidable) {
        self.numberOfRounds = numberOfRounds
        self.eventsPerRound = eventsPerRound
        self.eventProvider = eventProvider
    }
    
    func newGame() -> [EventDescriptable] {
        evaluations = []
        return nextRound()
    }
    
    func evaluate() -> EvaluationResult {
        // Check events sorted by the player against the solution
        for (index, currentEvent) in currentEvents.enumerated() {
            if !currentEvent.isEqual(other: solution[index]) {
                evaluations.append(.incorrect)
                return evaluations[evaluations.count - 1]
            }
        }
        
        evaluations.append(.correct)
        
        return evaluations[evaluations.count - 1]
    }
    
    func hasNextRound() -> Bool {
        return evaluations.count < numberOfRounds
    }
    
    func nextRound() -> [EventDescriptable] {
        currentEvents = eventProvider.random(numberOfEvents: eventsPerRound)
        
        // Sort the events to make them the solution
        solution = currentEvents.sorted {
            return $0.isBefore(event: $1)
        }
        
        return currentEvents
    }
    
    func permute(firstEvent left: Int, secondEvent right: Int) -> [EventDescriptable] {
        // Permute two events
        let bubbleEvent = currentEvents[left]
        currentEvents[left] = currentEvents[right]
        currentEvents[right] = bubbleEvent
        return currentEvents
    }
    
    func score() -> Scorable {
        var score: Int = 0
        
        for evaluation in evaluations {
            score += evaluation.rawValue
        }
        
        return Score(score: score, scoreMax: evaluations.count)
    }
    
    func retrieveSolution() -> [EventDescriptable] {
        return solution
    }
}
