//
//  RestaurantDetailTextCell.swift
//  Restaurants
//
//  Created by Jamaaldeen Opasina on 21/12/2023.
//

import UIKit

class RestaurantDetailTextCell: UITableViewCell {

 dev
    @IBOutlet var descriptionLabel: UILabel!{
        didSet{
            descriptionLabel.numberOfLines = 0
        }
    }
=======
 main
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
