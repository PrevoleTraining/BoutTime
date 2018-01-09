//
//  Eventable.swift
//  BoutTime
//
//  Created by PrevoleTraining on 15.12.17.
//  Copyright © 2017 PrevoleTraining. All rights reserved.
//

/**
 An event that can be ordered by year and an additional order attribute
 */
protocol Eventable: EventDescriptable, Comparable {
    var year: Int { get }
    var order: Int { get }
   
    /*
     Determine if an eventable is before another one.
     
     First the year should be compared, then the order if year is the same
     
     - parameter lhs: Left eventable
     - parameter rhs: Right eventable
     */
    static func <(lhs: Self, rhs: Self) -> Bool
}

extension Eventable {
    static func <(lhs: Self, rhs: Self) -> Bool {
        return lhs.year < rhs.year || (lhs.year == rhs.year && lhs.order < rhs.order)
    }
}
