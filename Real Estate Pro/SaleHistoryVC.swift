//
//  SaleHistoryVC.swift
//  Real Estate Pro
//
//  Created by Daniel J Janiak on 10/15/16.
//  Copyright © 2016 redwoodempiredev. All rights reserved.
//

import UIKit
import CoreData

class SaleHistoryVC: UIViewController {
    
    // MARK: - Properties
    
    var home: Home?
    
    weak var managedObjectContext: NSManagedObjectContext!
    
    var cellIdentifier = "SaleHistoryCell"
    
    lazy var previousSales = [SaleHistory]()
    
    // MARK: - Outlets
    
    @IBOutlet var homeImageView: UIImageView!
    
    @IBOutlet var saleHistoryTableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadHistory()
        
        if let homeImage = home!.image {
            let image = UIImage(data: homeImage)
            homeImageView.image = image
        }
        
        /* Don't display empty cells in the table */
        saleHistoryTableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private functions
    
    private func loadHistory(){
        
        let saleHistory = SaleHistory(context: managedObjectContext)
        previousSales = saleHistory.getHistoryForHome(home: home!, managedObjectContext: managedObjectContext)
        
        saleHistoryTableView.reloadData()
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

extension SaleHistoryVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return previousSales.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SaleHistoryCell
        
        let history = previousSales[indexPath.row]
        
        cell.configureCell(saleHistory: history)
        
        return cell
    }

}

