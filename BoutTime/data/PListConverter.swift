//
//  PListConverter.swift
//  BoutTime
//
//  Updated by lprevost on 15.12.17. (From treehouse 3rd course VendingMachine)
//  Copyright © 2017 prevole.ch. All rights reserved.
//

import Foundation

class PlistConverter {
    ///
    /// Load an array from a plist file
    ///
    static func array(fromFile name: String, ofType type: String) throws -> [AnyObject] {
        guard let url = Bundle.main.url(forResource: name, ofType: type) else {
            throw PListConverterError.invalidResource
        }
        
        guard let dictionary = NSArray(contentsOf: url) as [AnyObject]? else {
            throw PListConverterError.conversionFailure
        }
        
        return dictionary
    }
}
