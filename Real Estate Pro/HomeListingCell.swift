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
    
    @IBOutlet var bedValueLabel: UILabel!
    @IBOutlet var priceValueLabel: UILabel!
    
    @IBOutlet var cellImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cellImageView.layer.borderWidth = 1
        cellImageView.layer.cornerRadius = 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(home: Home) {
        
        cityLabel.text = home.city
        categoryLabel.text = home.homeType
        
        bedValueLabel.text = String(home.bed)
        priceValueLabel.text = home.price.currencyStringFormatter
        
        let homeImage = UIImage(data: home.image as! Data)
        cellImageView.image = homeImage
    }

}
