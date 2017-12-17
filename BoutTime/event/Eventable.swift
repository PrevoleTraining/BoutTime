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
protocol Eventable: EventDescriptable {
    var year: Int { get }
    var order: Int { get }
   
    /*
     Determine if an eventable is before another one.
     
     First the year should be compared, then the order if year is the same
     
     - parameter event: Another event to compare with
     */
    func isBefore(event: Eventable) -> Bool
}
