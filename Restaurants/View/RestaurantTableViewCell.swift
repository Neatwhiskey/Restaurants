//
//  RestaurantsTableViewCell.swift
//  Restaurants
//
//  Created by Jamaaldeen Opasina on 04/12/2023.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!{
        didSet{
            nameLabel.adjustsFontForContentSizeCategory = true
        }
    }
    @IBOutlet var locationLabel: UILabel!{
        didSet{
            locationLabel.adjustsFontForContentSizeCategory = true
        }
    }
    @IBOutlet var typeLabel: UILabel!{
        didSet{
            typeLabel.adjustsFontForContentSizeCategory = true
        }
    }
    @IBOutlet var thumbnailImageView: UIImageView! {
        didSet {
            thumbnailImageView.layer.cornerRadius = 20.0
            thumbnailImageView.clipsToBounds = true
        }
    }
    @IBOutlet var favoriteImageView: UIImageView! 
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.tintColor = .systemYellow
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
