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
    var restaurant: Restaurant = Restaurant()
    
        //MARK: - View Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.hidesBarsOnSwipe = false
        navigationItem.backButtonTitle = ""
            //configure header view
        headerView.headerRestaurantNameLabel.text = restaurant.name
        headerView.headerTypeLabel.text = restaurant.type
        headerView.headerImageView.image = UIImage(named: restaurant.image)
        let heartImage = restaurant.isFavorite ? "heart.fill" : "heart"
        headerView.heartButton.tintColor = restaurant.isFavorite ? .systemYellow : .white
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "showMap":
            let destinationController = segue.destination as! MapViewController
            destinationController.restaurant = restaurant
        case "showReview":
            let destinationController = segue.destination as! ReviewViewController
            destinationController.restaurant = restaurant
        default:
            break
        }
    }
    
    @IBAction func close(segue: UIStoryboardSegue){
        dismiss(animated: true, completion: nil)
    }
}



extension RestaurantDetailViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailTextCell.self), for: indexPath) as! RestaurantDetailTextCell
            cell.descriptionLabel.text = restaurant.description
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailTwoColumnCell.self), for: indexPath) as! RestaurantDetailTwoColumnCell
            cell.column1TextLabel.text = "Address"
            cell.column1TextLabel.text = restaurant.location
            cell.column2TitleLabel.text = "Phone Number"
            cell.column2TextLabel.text = restaurant.phone
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailMapCell.self), for: indexPath) as! RestaurantDetailMapCell
            cell.configure(location: restaurant.location)
            
            
            return cell
            
        default:
            fatalError("Failed to instantiate table view cell for detail view controller")
        }
    }
    
    
}

