//
//  Eventable.swift
//  BoutTime
//
//  Created by lprevost on 15.12.17.
//  Copyright © 2017 prevole.ch. All rights reserved.
//

protocol Eventable: EventDescriptable {
    var year: Int { get }
    var order: Int { get }
    
    func isBefore(event: Eventable) -> Bool
}
