//
//  Home+CoreDataClass.swift
//  Real Estate Pro
//
//  Created by Daniel J Janiak on 10/8/16.
//  Copyright © 2016 redwoodempiredev. All rights reserved.
//

import Foundation
import CoreData


public class Home: NSManagedObject {
    
    func getHomesBySaleStatus(isForSale: Bool, managedObjectContext: NSManagedObjectContext) -> [Home] {
        
        let fetchRequest: NSFetchRequest<Home> = Home.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "isForSale = %@", isForSale as CVarArg)
        
        do {
            
            let homesCollection = try managedObjectContext.fetch(fetchRequest)
            return homesCollection
            
        } catch {
            fatalError("Failed to fetch the list of homes")
        }
        
    }

}
