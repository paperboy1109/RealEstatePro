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
    
    func getHomesBySaleStatus(request: NSFetchRequest<Home>, managedObjectContext: NSManagedObjectContext) -> [Home] {
        
        do {
            
            let homesCollection = try managedObjectContext.fetch(request)
            return homesCollection
            
        } catch {
            fatalError("Failed to fetch the list of homes")
        }
        
    }

}
