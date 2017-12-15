//
//  EventCollectionUnarchiver.swift
//  BoutTime
//
//  Created by lprevost on 15.12.17.
//  Copyright © 2017 prevole.ch. All rights reserved.
//

import Foundation
import os.log

class EventCollectionUnarchiver {
    static let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "data")

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
