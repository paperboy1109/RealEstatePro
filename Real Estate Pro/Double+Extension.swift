//
//  Double+Extension.swift
//  Real Estate Pro
//
//  Created by Daniel J Janiak on 10/14/16.
//  Copyright © 2016 redwoodempiredev. All rights reserved.
//

import Foundation

extension Double {
    
    /* Easily create a string that expresses a value in terms of dollars */
    var currencyStringFormatter: String {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        
        return numberFormatter.string(from: NSNumber(value: self))!
        
    }
}
