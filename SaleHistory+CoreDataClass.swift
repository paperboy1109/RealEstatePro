//
//  SaleHistory+CoreDataClass.swift
//  Real Estate Pro
//
//  Created by Daniel J Janiak on 10/8/16.
//  Copyright © 2016 redwoodempiredev. All rights reserved.
//

import Foundation
import CoreData


public class SaleHistory: NSManagedObject {
    
    func getHistoryForHome(home: Home, managedObjectContext: NSManagedObjectContext) -> [SaleHistory] {
        
        let fetchRequest: NSFetchRequest<SaleHistory> = SaleHistory.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "home = %@", home as CVarArg)
        
        do {
            let soldHistory = try managedObjectContext.fetch(fetchRequest)
            return soldHistory
        }
        catch {
            fatalError("Error in getting the history of sales")
        }
    }

}
