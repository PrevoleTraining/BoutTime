//
//  File.swift
//  BoutTime
//
//  Created by lprevost on 15.12.17.
//  Copyright © 2017 prevole.ch. All rights reserved.
//

protocol EventDescriptable {
    var title: String { get }
    var url: String { get }
    
    func isEqual(other: EventDescriptable) -> Bool
}
