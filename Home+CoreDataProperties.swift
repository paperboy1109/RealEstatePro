//
//  Home+CoreDataProperties.swift
//  Real Estate Pro
//
//  Created by Daniel J Janiak on 10/8/16.
//  Copyright © 2016 redwoodempiredev. All rights reserved.
//

import Foundation
import CoreData

extension Home {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Home> {
        return NSFetchRequest<Home>(entityName: "Home");
    }

    @NSManaged public var city: String?
    @NSManaged public var price: Double
    @NSManaged public var bed: Int16
    @NSManaged public var bath: Int16
    @NSManaged public var sqft: Int16
    @NSManaged public var image: Data?
    @NSManaged public var homeType: String?
    @NSManaged public var isForSale: Bool
    @NSManaged public var saleHistory: NSSet?

}

// MARK: Generated accessors for saleHistory
extension Home {

    @objc(addSaleHistoryObject:)
    @NSManaged public func addToSaleHistory(_ value: SaleHistory)

    @objc(removeSaleHistoryObject:)
    @NSManaged public func removeFromSaleHistory(_ value: SaleHistory)

    @objc(addSaleHistory:)
    @NSManaged public func addToSaleHistory(_ values: NSSet)

    @objc(removeSaleHistory:)
    @NSManaged public func removeFromSaleHistory(_ values: NSSet)

}
