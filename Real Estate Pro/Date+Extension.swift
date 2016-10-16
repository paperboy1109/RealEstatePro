//
//  Date+Extension.swift
//  Real Estate Pro
//
//  Created by Daniel J Janiak on 10/15/16.
//  Copyright © 2016 redwoodempiredev. All rights reserved.
//

import Foundation

extension Date {
    
    /* Easily display a date as a string */
    var toString: String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: self)
    }
}
