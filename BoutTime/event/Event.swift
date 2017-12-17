//
//  Event.swift
//  BoutTime
//
//  Created by PrevoleTraining on 15.12.17.
//  Copyright © 2017 PrevoleTraining. All rights reserved.
//

/*
 An event in this game is a book in the Star Wars Universe (before classified Legends)
 
 Each event has the book title, the year in the Star Wars timeline and an additional ordering value
 in case a book takes time in the same year that another one.
 */
class Event: Eventable {
    let title: String
    let url: String
    let year: Int
    let order: Int
    
    /**
     Constructor
 
     - parameter title: The event title
     - parameter url: URL to get more details of the event
     - parameter year: The year of the event
     - parameter order: The alternative precision to sort events in the same year
     */
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
