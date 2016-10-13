//
//  HomeListingCell.swift
//  Real Estate Pro
//
//  Created by Daniel J Janiak on 10/12/16.
//  Copyright © 2016 redwoodempiredev. All rights reserved.
//

import UIKit

class HomeListingCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
