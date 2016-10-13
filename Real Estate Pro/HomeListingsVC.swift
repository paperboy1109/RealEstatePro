//
//  HomeListingsVC.swift
//  Real Estate Pro
//
//  Created by Daniel J Janiak on 10/12/16.
//  Copyright © 2016 redwoodempiredev. All rights reserved.
//

import UIKit

class HomeListingsVC: UIViewController {
    
    // MARK: - Properties
    
    let cellIdentifier = "HomeListCell"
    
    // MARK: - Outlets
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var homeListTableView: UITableView!

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

extension HomeListingsVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        return cell
    }
    
    
    
}
