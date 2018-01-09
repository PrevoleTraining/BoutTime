//
//  EventProvider.swift
//  BoutTime
//
//  Created by PrevoleTraining on 15.12.17.
//  Copyright © 2017 PrevoleTraining. All rights reserved.
//

import GameKit

/**
 Implementation of the event service
 */
class EventProvider: EventProvidable {
    let events: [Event]
    
    required init(events: [Event]) {
        self.events = events
    }
    
    func random(numberOfEvents number: Int) -> [Event] {
        var eventsCopy = events
        
        var randomEvents: [Event] = []
   
        // Make the random choice of events making sure no event is chosen twice
        for _ in 0..<number {
            let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: eventsCopy.count)
            randomEvents.append(eventsCopy.remove(at: randomNumber))
        }
        
        return randomEvents
    }
}
