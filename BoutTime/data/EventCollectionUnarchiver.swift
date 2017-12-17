//
//  EventCollectionUnarchiver.swift
//  BoutTime
//
//  Created by PrevoleTraining on 15.12.17.
//  Copyright © 2017 PrevoleTraining. All rights reserved.
//

import Foundation
import os.log

/**
 Converter of events loaded from a plist to the events collection
 */
class EventCollectionUnarchiver {
    static let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "data")

    /**
     Convert the array of events not typed to the events usable in the game
     
     - parameter fromArray: Array of untyped events
     
     - return Collection of events
     */
    static func events(fromArray array: [AnyObject]) throws -> [Eventable] {
        var events: [Eventable] = []
        
        for (index, raw) in array.enumerated() {
            if let itemDictionary = raw as? [String: Any],
                let title = itemDictionary["title"] as? String,
                let url = itemDictionary["url"] as? String,
                let year = itemDictionary["year"] as? Int,
                let order = itemDictionary["order"] as? Int {
                let event = Event(title: title, url: url, year: year, order: order)
                
                events.append(event)
            } else {
                os_log("Unable to load the event %@", log: log, type: .info, index)
            }
        }
        
        return events
    }
}
