//
//  GameEngine.swift
//  BoutTime
//
//  Created by lprevost on 15.12.17.
//  Copyright © 2017 prevole.ch. All rights reserved.
//

class GameEngine: Gamable {
    let numberOfRounds: Int
    let eventsPerRound: Int
    
    let eventProvider: EventProvidable
    
    var evaluations: [EvaluationResult] = []
    
    var currentEvents: [Eventable] = []
    
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
        // We check e and e + 1 to see the ordering
        for currentEventIndex in 0..<currentEvents.count - 2 {
            // Return incorrect result if event is not before the next one
            if !currentEvents[currentEventIndex].isBefore(event: currentEvents[currentEventIndex + 1]) {
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
        return currentEvents
    }
    
    func permute(firstEvent left: Int, secondEvent right: Int) -> [EventDescriptable] {
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
        return currentEvents.sorted {
            return $0.isBefore(event: $1)
        }
    }
}
