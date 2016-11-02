//
//  FilterTableViewController.swift
//  Real Estate Pro
//
//  Created by Daniel J Janiak on 10/30/16.
//  Copyright © 2016 redwoodempiredev. All rights reserved.
//

import UIKit

protocol FilterTableViewControllerDelegate {
    
    func updateHomeList(filterBy: NSPredicate?, sortBy: NSSortDescriptor?)
    
}

class FilterTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var sortDescriptor: NSSortDescriptor?
    var searchPredicate: NSPredicate?
    
    var delegate: FilterTableViewControllerDelegate!
    
    // MARK: - Outlets
    
    @IBOutlet var sortByLocationCell: UITableViewCell!
    @IBOutlet var sortByPriceLowHighCell: UITableViewCell!
    @IBOutlet var sortByPriceHighLowCell: UITableViewCell!
    
    @IBOutlet var filterByCondoCell: UITableViewCell!
    @IBOutlet var filterBySingleFamilyCell: UITableViewCell!
    
    // MARK: - Lifecycle
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? 3 :2
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath)!
        
        switch selectedCell {
            
        case sortByLocationCell:
            setSortDescriptor(sortBy: "city", isAscending: true)
            
        case sortByPriceLowHighCell:
            setSortDescriptor(sortBy: "price", isAscending: true)
            
        case sortByPriceHighLowCell:
            setSortDescriptor(sortBy: "price", isAscending: false)
            
        case filterByCondoCell, filterBySingleFamilyCell:
            setFilterSearchPredicate(filterBy: selectedCell.textLabel!.text!)
            
        default:
            print("No cell selected")
        }
        
        selectedCell.accessoryType = .checkmark
        
        delegate.updateHomeList(filterBy: searchPredicate, sortBy: sortDescriptor)
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Helpers
    
    private func setSortDescriptor(sortBy: String, isAscending: Bool) {
        
        sortDescriptor = NSSortDescriptor(key: sortBy, ascending: isAscending)
        
    }
    
    private func setFilterSearchPredicate(filterBy: String) {
        
        searchPredicate = NSPredicate(format: "homeType = %@", filterBy)
    }

}
