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
    
    // MARK: - Outlets
    
    @IBOutlet var homeImageView: UIImageView!
    
    @IBOutlet var saleHistoryTableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SaleHistoryCell
        
        return cell
    }

}

