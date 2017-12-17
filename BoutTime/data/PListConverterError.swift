//
//  PListConverterError.swift
//  BoutTime
//
//  Created by PrevoleTraining on 15.12.17.
//  Copyright © 2017 PrevoleTraining. All rights reserved.
//

/**
 Plist converter errors
 */
enum PListConverterError: Error {
    /**
     When the file cannot be found
     */
    case invalidResource
    
    /**
     When the file cannot be loaded
     */
    case conversionFailure
}
