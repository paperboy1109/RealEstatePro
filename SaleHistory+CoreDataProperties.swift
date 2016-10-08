//
//  SaleHistory+CoreDataProperties.swift
//  Real Estate Pro
//
//  Created by Daniel J Janiak on 10/8/16.
//  Copyright © 2016 redwoodempiredev. All rights reserved.
//

import Foundation
import CoreData

extension SaleHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SaleHistory> {
        return NSFetchRequest<SaleHistory>(entityName: "SaleHistory");
    }

    @NSManaged public var soldPrice: Double
    @NSManaged public var soldDate: Date?
    @NSManaged public var home: Home?

}
