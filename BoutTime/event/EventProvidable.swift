//
//  EventProvidable.swift
//  BoutTime
//
//  Created by PrevoleTraining on 15.12.17.
//  Copyright © 2017 PrevoleTraining. All rights reserved.
//

/**
 Service to provide random events
 */
protocol EventProvidable {
    /**
     Constructor
     
     - parameter events: The events at disposal to chose randomly
     */
    init(events: [Eventable])
    
    /**
     Choose a number of events randomly
 
     - parameter numberOfEvents: The number of events to choose
     
     - return Collection of chosen events
     */
    func random(numberOfEvents number: Int) -> [Eventable]
}
