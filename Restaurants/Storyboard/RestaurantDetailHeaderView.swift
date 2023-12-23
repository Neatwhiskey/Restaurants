//
//  RestaurantDetailHeaderView.swift
//  Restaurants
//
//  Created by Jamaaldeen Opasina on 19/12/2023.
//

import UIKit

class RestaurantDetailHeaderView: UIView {
 
    
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var headerRestaurantNameLabel: UILabel!{
        didSet{
            headerRestaurantNameLabel.numberOfLines = 0
            
            if let customFont = UIFont(name: "Nunito-Bold", size: 40.0){
                headerRestaurantNameLabel.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: customFont)
            }
        }
    }
    @IBOutlet var headerTypeLabel: UILabel!{
        didSet{
            if let customFont = UIFont(name: "Nunito-Bold", size: 20.0){
                headerTypeLabel.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: customFont)
            }
        }
    }
    @IBOutlet var heartButton: UIButton!


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
