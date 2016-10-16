//
//  SaleHistoryCell.swift
//  Real Estate Pro
//
//  Created by Daniel J Janiak on 10/15/16.
//  Copyright © 2016 redwoodempiredev. All rights reserved.
//

import UIKit

class SaleHistoryCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet var dateOfSaleLabel: UILabel!
    
    @IBOutlet var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
