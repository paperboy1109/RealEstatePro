//
//  HomeListingsVC.swift
//  Real Estate Pro
//
//  Created by Daniel J Janiak on 10/12/16.
//  Copyright © 2016 redwoodempiredev. All rights reserved.
//

import UIKit
import CoreData

class HomeListingsVC: UIViewController {
    
    // MARK: - Properties
    
    let cellIdentifier = "HomeListCell"
    
    weak var managedObjectContext: NSManagedObjectContext! {
        // The managed object context will be set by the app delegate at launch
        didSet {
            return home = Home(context: managedObjectContext)
        }
    }
    lazy var homes = [Home]()
    var home: Home? = nil
    var isForSale: Bool = true
    var selectedHome: Home?
    
    var sortDescriptor = [NSSortDescriptor]()
    var searchPredicate: NSPredicate?
    
    var fetchRequest: NSFetchRequest<Home>?
    
    // MARK: - Outlets
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var homeListTableView: UITableView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // loadData()
        
        print("\n\n The number of homes is : \(homes.count))")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchRequest = Home.fetchRequest()
        
        loadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private functions
    
    private func loadData() {
        
        /* Load data based on any sorting and filtering options set by the user */
        
        var predicates = [NSPredicate]()
        
        // Show homes according to the option set on the segmented control
        
        let statusPredicate = NSPredicate(format: "isForSale = %@", isForSale as CVarArg)
        
        predicates.append(statusPredicate)
        
        
        // Filtering
        
        if let additionalPredicate = searchPredicate {
            predicates.append(additionalPredicate)
        }
        
        let predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: predicates)
        
        fetchRequest?.predicate = predicate
        
        // Sorting
        
        if sortDescriptor.count > 0 {
            fetchRequest?.sortDescriptors = sortDescriptor
        }
        
        // Fetch the data to be displayed
        
        homes = home!.getHomesBySaleStatus(request: fetchRequest!, managedObjectContext: managedObjectContext)
        
        homeListTableView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction func segmentedControlValueChanged(_ sender: AnyObject) {
        
        let currentSegmentedControlValue = sender.titleForSegment(at: sender.selectedSegmentIndex)
        
        /* Update the isForSale property accordingly */
        isForSale = currentSegmentedControlValue == "For Sale" ? true : false
        
        /* Update the data */
        loadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ToSaleHistory" {
            
            let selectedIndexPath = homeListTableView.indexPathForSelectedRow
            selectedHome = homes[selectedIndexPath!.row]
            
            let destinationVC = segue.destination as! SaleHistoryVC
                        
            destinationVC.home = selectedHome
            destinationVC.managedObjectContext = managedObjectContext
            
        } else if segue.identifier == "ToSortAndFilterOptions" {
            
            /* Remove previous filters */
            sortDescriptor = []
            searchPredicate = nil
            
            let controller = segue.destination as! FilterTableViewController
            controller.delegate = self
            
        }

    } 

}


// MARK: - TableView Delegate Methods

extension HomeListingsVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HomeListingCell
        
        let currentHome = homes[indexPath.row]

        cell.configureCell(home: currentHome)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ToSaleHistory", sender: self)
        
    }
}

// MARK: - FilterTableViewControllerDelegate protocol implementation

extension HomeListingsVC: FilterTableViewControllerDelegate {
    
    func updateHomeList(filterBy: NSPredicate?, sortBy: NSSortDescriptor?) {
        
        if let filter = filterBy {
            searchPredicate = filter
        }
        
        if let sort = sortBy {
            sortDescriptor.append(sort)
        }
    }
    
}
