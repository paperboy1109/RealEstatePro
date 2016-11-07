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
    
    typealias HomeByStatusHandler = (_ homes: [Home]) -> Void
    
    // MARK: - Properties
    
    var soldPredicate: NSPredicate = NSPredicate(format: "isForSale = false")
    let request: NSFetchRequest<Home> = Home.fetchRequest()
    
    internal func getHomesBySaleStatus(request: NSFetchRequest<Home>, managedObjectContext: NSManagedObjectContext, completionHandler: @escaping HomeByStatusHandler) {
        
        let asynchronousRequest = NSAsynchronousFetchRequest(fetchRequest: request) { (results: NSAsynchronousFetchResult<Home>) in
            
            let homes = results.finalResult!
            
            completionHandler(homes)
            
        }
        
        do {
            
//            let homesCollection = try managedObjectContext.fetch(request)
//            return homesCollection

            try managedObjectContext.execute(asynchronousRequest)
            
        } catch {
            fatalError("Failed to fetch the list of homes")
        }
        
    }
    
    internal func getTotalHomeSales(managedObjectContext: NSManagedObjectContext) -> String {
        
        request.predicate = soldPredicate
        request.resultType = .dictionaryResultType
        
        let sumExpressionDescription = NSExpressionDescription()
        sumExpressionDescription.name = "totalSales"
        sumExpressionDescription.expression = NSExpression(forFunction: "sum:", arguments: [NSExpression(forKeyPath: "price")])
        sumExpressionDescription.expressionResultType = .doubleAttributeType
        
        request.propertiesToFetch = [sumExpressionDescription]
        
        do {
            
            let results = try managedObjectContext.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [NSDictionary]
            
            let resultsDictionary = results.first!
            
            let totalSales = resultsDictionary["totalSales"] as! Double
            
            return totalSales.currencyStringFormatter
            
        } catch {
            fatalError("Failed to get the total home sales")
        }
    }
    
    internal func getNumberOfCondosSold(managedObjectContext: NSManagedObjectContext) -> String {
        
        let homeTypePredicate = NSPredicate(format: "homeType = 'Condo'")
        
        let predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [soldPredicate, homeTypePredicate])
        
        request.resultType = .countResultType
        request.predicate = predicate
        
        var count: NSNumber!
        
        do{
            
            let results = try managedObjectContext.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [NSNumber]
            
            count = results.first
            
        } catch {
            fatalError("Failed to count the number of condos sold")
        }
        
        return count.stringValue
    }
    
    internal func getNumberOfSingleFamilyHomesSold(managedObjectContext: NSManagedObjectContext) -> String {
        
        let homeTypePredicate = NSPredicate(format: "homeType = 'Single Family'")
        
        let predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [soldPredicate, homeTypePredicate])
        
        request.predicate = predicate
        
        do {
            
            let count = try managedObjectContext.count(for: request)
            
            if count != NSNotFound {
                return String(count)
            } else {
                fatalError("Failed to return the count of (sold) single family homes")
            }
            
        } catch {
            fatalError("Failed to count the number of single family homes sold")
        }
        
    }
    
    internal func getHomePriceSold(maxOrMin: String, managedObjectContext: NSManagedObjectContext) -> String {
        
        request.predicate = soldPredicate
        request.resultType = .dictionaryResultType
        
        let sumExpressionDescription = NSExpressionDescription()
        sumExpressionDescription.name = maxOrMin
        sumExpressionDescription.expression = NSExpression(forFunction: "\(maxOrMin):", arguments: [NSExpression(forKeyPath: "price")])
        sumExpressionDescription.expressionResultType = .doubleAttributeType
        
        request.propertiesToFetch = [sumExpressionDescription]
        
        do {
            
            let results = try managedObjectContext.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [NSDictionary]
            
            let resultsDictionary = results.first!
            
            let maxOrMinPrice = resultsDictionary[maxOrMin] as! Double
            
            return maxOrMinPrice.currencyStringFormatter
            
        } catch {
            fatalError("Failed to get \(maxOrMin) for home sales")
        }
    }
    
    internal func getAverageHomePrice(homeType: String, managedObjectContext: NSManagedObjectContext) -> String {
        
        let homeTypePredicate = NSPredicate(format: "homeType = %@", homeType)
        
        let predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [soldPredicate, homeTypePredicate])
        
        request.predicate = predicate
        request.resultType = .dictionaryResultType
        
        let sumExpressionDescription = NSExpressionDescription()
        sumExpressionDescription.name = homeType
        sumExpressionDescription.expression = NSExpression(forFunction: "average:", arguments: [NSExpression(forKeyPath: "price")])
        sumExpressionDescription.expressionResultType = .doubleAttributeType
        
        request.propertiesToFetch = [sumExpressionDescription]
        
        do {
            
            let results = try managedObjectContext.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [NSDictionary]
            
            let resultsDictionary = results.first!
            
            let avePrice = resultsDictionary[homeType] as! Double
            
            return avePrice.currencyStringFormatter
            
        } catch {
            fatalError("Failed to get the average for \(homeType) sales")
        }
        
    }

}
