//
//  Event.swift
//  BoutTime
//
//  Created by lprevost on 15.12.17.
//  Copyright © 2017 prevole.ch. All rights reserved.
//

class Event: Eventable {
    let title: String
    let url: String
    let year: Int
    let order: Int
    
    init(title: String, url: String, year: Int, order: Int) {
        self.title = title
        self.url = url
        self.year = year
        self.order = order
    }
    
    func isBefore(event: Eventable) -> Bool {
        return year < event.year || (year == event.year && order < event.order)
    }
    
    func isEqual(other: EventDescriptable) -> Bool {
        return title == other.title
    }
}
