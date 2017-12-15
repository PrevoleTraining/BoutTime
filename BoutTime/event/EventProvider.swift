//
//  EventProvider.swift
//  BoutTime
//
//  Created by lprevost on 15.12.17.
//  Copyright © 2017 prevole.ch. All rights reserved.
//

import GameKit

class EventProvider: EventProvidable {
    let events: [Eventable]
    
    required init(events: [Eventable]) {
        self.events = events
    }
    
    func random(numberOfEvents number: Int) -> [Eventable] {
        var eventsCopy = events
        
        var randomEvents: [Eventable] = []
        
        for _ in 0..<number {
            let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: eventsCopy.count)
            randomEvents.append(eventsCopy.remove(at: randomNumber))
        }
        
        return randomEvents
    }
}
