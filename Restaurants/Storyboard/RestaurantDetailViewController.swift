//
//  RestaurantDetailViewController.swift
//  Restaurants
//
//  Created by Jamaaldeen Opasina on 17/12/2023.
//

import UIKit

 
class RestaurantDetailViewController: UIViewController{
    
    

    @IBOutlet var headerView: RestaurantDetailHeaderView!
    @IBOutlet var tableView: UITableView!
    var restaurants: Restaurant = Restaurant()
    
    //MARK: - View Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.hidesBarsOnSwipe = false
            //configure header view
        headerView.headerRestaurantNameLabel.text = restaurants.name
        headerView.headerTypeLabel.text = restaurants.type
        headerView.headerImageView.image = UIImage(named: restaurants.image)
        let heartImage = restaurants.isFavorite ? "heart.fill" : "heart"
        headerView.heartButton.tintColor = restaurants.isFavorite ? .systemYellow : .white
        headerView.heartButton.setImage(UIImage(named: heartImage), for: .normal)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

 

extension RestaurantDetailViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailTextCell.self), for: indexPath) as! RestaurantDetailTextCell
            cell.descriptionLabel.text = restaurants.description
            
            return cell
        
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailTwoColumnCell.self), for: indexPath) as! RestaurantDetailTwoColumnCell
            cell.column1TextLabel.text = "Address"
            cell.column1TextLabel.text = restaurants.location
            cell.column2TitleLabel.text = "Phone Number"
            cell.column2TextLabel.text = restaurants.phone
        
            return cell
        default:
            fatalError("Failed to instantiate table view cell for detail view controller")
        }
    }
    
    
}

