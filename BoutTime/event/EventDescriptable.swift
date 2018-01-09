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
protocol EventDescriptable: Equatable {
    var title: String { get }
    var url: String { get }
}

extension EventDescriptable {
    /**
     Check if an event is equal with another one
     
     - parameter lhs: The left event descriptable
     - parameter rhs: The right event descriptable
     
     - return True if both events are the same
     */
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.title == rhs.title
    }
}
