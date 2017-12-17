//
//  PListConverter.swift
//  BoutTime
//
//  Updated by PrevoleTraining on 15.12.17. (From treehouse 3rd course VendingMachine)
//  Copyright © 2017 PrevoleTraining. All rights reserved.
//

import Foundation

class PlistConverter {
    /**
     Load an array from a plist file
     
     - parameter fromFile: The file to load
     - parameter ofType: The extension of the file
     
     - return The array of any object loaded from the file
     */
    static func array(fromFile name: String, ofType type: String) throws -> [AnyObject] {
        // Make sure the file exist
        guard let url = Bundle.main.url(forResource: name, withExtension: type) else {
            throw PListConverterError.invalidResource
        }
        
        // Make sure the file can be loaded
        guard let dictionary = NSArray(contentsOf: url) as [AnyObject]? else {
            throw PListConverterError.conversionFailure
        }
        
        return dictionary
    }
}
