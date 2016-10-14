//
//  AppDelegate.swift
//  Real Estate Pro
//
//  Created by Daniel J Janiak on 10/8/16.
//  Copyright © 2016 redwoodempiredev. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coreDataStack = CoreDataStack()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let managedObjectContext = coreDataStack.persistentContainer.viewContext
        
        let tabBarController = self.window?.rootViewController as! UITabBarController
        let homeListingsNavController = tabBarController.viewControllers?[0] as! UINavigationController
        let homeListingsVC = homeListingsNavController.topViewController as! HomeListingsVC
        homeListingsVC.mangedObjectContext = managedObjectContext
        
        
        // For debugging
        //deleteAllRecords()
        //checkDataStore()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        coreDataStack.saveContext()
    }
    
    // MARK: - Import data from the homes.json file
    
    func checkDataStore() {
        
        let fetchRequest: NSFetchRequest<Home> = Home.fetchRequest()
        
        let managedObjectContext = coreDataStack.persistentContainer.viewContext
        
        do {
            let homeTotal = try managedObjectContext.count(for: fetchRequest)
            
            print("\n\nHere is the total number of homes in the database at app launch: \(homeTotal)")
            
            if homeTotal == 0 {
                loadSampleData()
            }            
            
            loadSampleData()
            
        } catch {
            fatalError("Failed to count the home records")
        }
    }
    
    func loadSampleData() {
        
        let managedObjectContext = coreDataStack.persistentContainer.viewContext
        
        let fileUrl = Bundle.main.url(forResource: "homes", withExtension: "json")
        
        let data = try? Data(contentsOf: fileUrl!)
        
        do {
            
            let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            
            let jsonArray = jsonResult.value(forKey: "home") as! NSArray
            
            for item in jsonArray {
                
                let homeData = item as! [String: AnyObject]
                
                /* Parse the data */
                
                    // Defensive coding
                
                guard let city = homeData["city"] else {
                    return
                }
                
                guard let price = homeData["price"] else {
                    return
                }
                
                guard let bed = homeData["bed"] else {
                    return
                }
                
                guard let bath = homeData["bath"] else {
                    return
                }
                
                guard let sqft = homeData["sqft"] else {
                    return
                }
                
                    // The home image
                var homeImage: UIImage?
                if let currentImage = homeData["image"] {
                    let imageName = currentImage as? String
                    homeImage = UIImage(named: imageName!)
                }
                
                    // Condo or single family?
                guard let homeCategory = homeData["category"] else {
                    return
                }
                
                let homeType = (homeCategory as! NSDictionary)["homeType"] as? String
                
                    // Is the home on the market?
                guard let homeStatus = homeData["status"] else {
                    return
                }
                
                let isForSale = (homeStatus as! NSDictionary)["isForSale"] as? Bool
                
                /* Use the data to populate entities */
                
                let home = homeType?.caseInsensitiveCompare("condo") == .orderedSame ? Condo(context: managedObjectContext) : SingleFamily(context: managedObjectContext)
                
                home.city = city as? String
                home.homeType = homeType
                home.price = price as! Double
                home.bed = bed.int16Value
                home.bath = bath.int16Value
                home.sqft = sqft.int16Value
                home.isForSale = isForSale!
                
                home.image = NSData.init(data: UIImageJPEGRepresentation(homeImage!, 1.0)!)
                
                /* Condos vs. Single Family homes have different properties: unitsPerBuilding and lotSize, respectively */
                if let unitsPerBuilding = homeData["unitsPerBuilding"] {
                    (home as! Condo).unitsPerBuilding = unitsPerBuilding.int16Value
                }
                
                if let lotSize = homeData["lotSize"] {
                    (home as! SingleFamily).lotSize = lotSize.int16Value
                }
                
                if let saleHistoryCollection = homeData["saleHistory"] {
                    
                    let saleHistoryData = home.saleHistory?.mutableCopy() as! NSMutableSet
                    
                    for item in saleHistoryCollection as! NSArray {
                        
                        let saleData = item as! [String: AnyObject]
                        
                        let saleHistory = SaleHistory(context: managedObjectContext)
                        saleHistory.soldPrice = saleData["soldPrice"] as! Double
                        
                        let soldDateString = saleData["soldDate"] as! String
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        let soldDate = dateFormatter.date(from: soldDateString)
                        saleHistory.soldDate = soldDate
                        
                        saleHistoryData.add(saleHistory)
                        
                        home.addToSaleHistory(saleHistoryData)
                    }
                }
            }
            
            coreDataStack.saveContext()
            
        } catch {
            fatalError("Failed to load sample data")
        }
        
    }
    
    func deleteAllRecords() {
        
        let managedObjectContext = coreDataStack.persistentContainer.viewContext
        
        let fetchRequestForHome: NSFetchRequest<Home> = Home.fetchRequest()
        
        let fetchRequestForSaleHistory: NSFetchRequest<SaleHistory> = SaleHistory.fetchRequest()
        
        var fetchRequestForDeletion: NSBatchDeleteRequest
        var deleteResults: NSPersistentStoreResult
        
        do {
            
            fetchRequestForDeletion = NSBatchDeleteRequest(fetchRequest: fetchRequestForHome as! NSFetchRequest<NSFetchRequestResult>)
            deleteResults = try managedObjectContext.execute(fetchRequestForDeletion)
            
            fetchRequestForDeletion = NSBatchDeleteRequest(fetchRequest: fetchRequestForSaleHistory as! NSFetchRequest<NSFetchRequestResult>)
            deleteResults = try managedObjectContext.execute(fetchRequestForDeletion)
            
        } catch {
            fatalError("Failed to remove the existing records")
        }
    }


}

