//
//  EventProvidable.swift
//  BoutTime
//
//  Created by lprevost on 15.12.17.
//  Copyright © 2017 prevole.ch. All rights reserved.
//

protocol EventProvidable {
    init(events: [Eventable])
    
    func random(numberOfEvents number: Int) -> [Eventable]
}
