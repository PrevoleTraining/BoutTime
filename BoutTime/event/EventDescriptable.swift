//
//  File.swift
//  BoutTime
//
//  Created by PrevoleTraining on 15.12.17.
//  Copyright © 2017 PrevoleTraining. All rights reserved.
//

/**
 Offer an event that can be described
 */
protocol EventDescriptable {
    var title: String { get }
    var url: String { get }
   
    /**
     Check if an event is equal with another one
 
     - parameter other: The other event to compare with
     
     - return True if both events are the same
     */
    func isEqual(other: EventDescriptable) -> Bool
}
