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
    
    weak var mangedObjectContext: NSManagedObjectContext! {
        // The managed object context will be set by the app delegate at launch
        didSet {
            return home = Home(context: mangedObjectContext)
        }
    }
    lazy var homes = [Home]()
    var home: Home? = nil
    var isForSale: Bool = true
    
    // MARK: - Outlets
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var homeListTableView: UITableView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        
        print("\n\n The number of homes is : \(homes.count))")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private functions
    
    private func loadData() {
        
        homes = home!.getHomesBySaleStatus(isForSale: isForSale, managedObjectContext: mangedObjectContext)
        
        homeListTableView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
        
        cell.categoryLabel.text = currentHome.homeType
        cell.cityLabel.text = currentHome.city
        
        return cell
    }
    
    
    
}