//
//  RestaurantsTableViewController.swift
//  Restaurants
//
//  Created by Jamaaldeen Opasina on 04/12/2023.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController{
    
    var fetchResultController: NSFetchedResultsController<Restaurant>!
    
    var searchController: UISearchController!
    
    @IBOutlet var emptyRestaurantView: UIView!
    
    var restaurants:[Restaurant] = []
    
    lazy var dataSource = configureDataSource()
    
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // search controller
        searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search restaurants..."
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.tintColor = UIColor(named: "NavigationBarTitle")
        
        if let appearance = navigationController?.navigationBar.standardAppearance{
            appearance.configureWithTransparentBackground()
            
            if let customFont = UIFont(name: "Nunito-Bold", size: 45.0){
                appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!,.font: customFont]
            }
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backButtonTitle = ""
        navigationController?.hidesBarsOnSwipe = true
        
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
        
       fetchRestaurantData()
        updateSnapShot()
        
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        tableView.backgroundView = emptyRestaurantView
        tableView.backgroundView?.isHidden = restaurants.count == 0 ? false : true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough") {
            return
        }
        
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let walkthroughViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughViewController") as? WalkthroughViewController {
            
            present(walkthroughViewController, animated: true, completion: nil)
        }
    }
    
    //MARK: - Core Data
    
    func fetchRestaurantData(searchText: String = ""){
        //fetch data from the data store
        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        
        if !searchText.isEmpty{
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS[c] %@ OR location CONTAINS[c] %@", searchText)
        }
        
        let sortDesriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDesriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do{
                try fetchResultController.performFetch()
                updateSnapShot(animatingChange: searchText.isEmpty ? false : true)
            }catch{
                print(error)
            }
        }
    }
    
    func updateSnapShot(animatingChange: Bool = false){
        
        if let fetchedObjects = fetchResultController.fetchedObjects{
            restaurants = fetchedObjects
        }
        //create a snapshot to populate data
        var snapShot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapShot.appendSections([.all])
        snapShot.appendItems(restaurants, toSection: .all)
        
        dataSource.apply(snapShot, animatingDifferences: animatingChange)
        tableView.backgroundView?.isHidden = restaurants.count == 0 ? false: true
    }

    // MARK: - UITableView Diffable Data Source
    
    func configureDataSource() -> RestaurantDiffableDataSource {
        
        let cellIdentifier = "datacell"
        
        let dataSource = RestaurantDiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, restaurant in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
                
                cell.nameLabel.text = restaurant.name
                cell.locationLabel.text = restaurant.location
                cell.typeLabel.text = restaurant.type
                cell.thumbnailImageView.image = UIImage(data: restaurant.image)
                cell.favoriteImageView.isHidden = restaurant.isFavorite ? false : true
                
                return cell
            }
        )
        
        return dataSource
    }
    
   
    
    // MARK: - UITableViewDelegate Protocol
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        
//            // Create an option menu as an action sheet
//        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
//        
//        if let popoverController = optionMenu.popoverPresentationController {
//            if let cell = tableView.cellForRow(at: indexPath) {
//                popoverController.sourceView = cell
//                popoverController.sourceRect = cell.bounds
//            }
//        }
//        
//            // Add actions to the menu
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        optionMenu.addAction(cancelAction)
//        
//            // Add "Reserve a table" action
//        
//        let reserveActionHandler = { (action:UIAlertAction!) -> Void in
//            
//            let alertMessage = UIAlertController(title: "Not available yet", message: "Sorry, this feature is not available yet. Please retry later.", preferredStyle: .alert)
//            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alertMessage, animated: true, completion: nil)
//            
//        }
//        
//        let reserveAction = UIAlertAction(title: "Reserve a table", style: .default, handler: reserveActionHandler)
//        optionMenu.addAction(reserveAction)
//        
//            // Mark as favorite action
//        
//        let favoriteActionTitle = self.restaurants[indexPath.row].isFavorite ? "Remove from favorites" : "Mark as favorite"
//        let favoriteAction = UIAlertAction(title: favoriteActionTitle, style: .default, handler: {
//            (action:UIAlertAction!) -> Void in
//            
//            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
//            
//            cell.favoriteImageView.isHidden = self.restaurants[indexPath.row].isFavorite
//            
//            self.restaurants[indexPath.row].isFavorite = self.restaurants[indexPath.row].isFavorite ? false : true
//            
//        })
//        optionMenu.addAction(favoriteAction)
//        
//            // Display the menu
//        present(optionMenu, animated: true, completion: nil)
//        
//            // Deselect the row
//        tableView.deselectRow(at: indexPath, animated: false)
//    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if searchController.isActive{
            return UISwipeActionsConfiguration()
        }
        
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath)else{
            return UISwipeActionsConfiguration()
        }
        
            //DeleteAction
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){(action,sourceView,completionHandler) in
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
                let context = appDelegate.persistentContainer.viewContext
                //Delete item
                context.delete(restaurant)
                appDelegate.saveContext()
                
                self.updateSnapShot(animatingChange: true)
            }
            
                //call completionhandler to dismiss the action button
            completionHandler(true)
            
        }
        
            //share action
        let shareAction = UIContextualAction(style: .normal, title: "share"){(action,sourceView,completionHandler) in
            let defaultText = "Just checking in at " + restaurant.name
            let activityController : UIActivityViewController
            
            if let imageToShare = UIImage(data: restaurant.image){
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare],applicationActivities: nil)
            }else{
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
                
            }
            
            if let popoverPresentationController = activityController.popoverPresentationController{
                if let cell = tableView.cellForRow(at: indexPath){
                    popoverPresentationController.sourceView = cell
                    popoverPresentationController.sourceRect = cell.bounds
                }
            }
            
            self.present(activityController, animated: true, completion:nil)
            completionHandler(true)
        }
        shareAction.backgroundColor = UIColor.systemOrange
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        
        deleteAction.backgroundColor = UIColor.systemRed
        deleteAction.image = UIImage(systemName: "trash")
        
        
            //configure both actions as swipe actions
        let swipeActionConfiguration = UISwipeActionsConfiguration(actions: [deleteAction,shareAction])
        return swipeActionConfiguration
    }
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

            //Mark as Favorite Action
            let favoriteAction = UIContextualAction(style: .normal, title: "favorite"){(action,sourceView,completionHandler)in
                let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
                
                cell.favoriteImageView.isHidden = self.restaurants[indexPath.row].isFavorite
                
                self.restaurants[indexPath.row].isFavorite = self.restaurants[indexPath.row].isFavorite ? false : true
                //call completion handler to dismiss the action
                completionHandler(true)
            }
        favoriteAction.backgroundColor = UIColor.systemYellow
        favoriteAction.image = UIImage(systemName: self.restaurants[indexPath.row].isFavorite ? "heart.slash.fill" : "heart.fill")
        let swipeActionConfiguration = UISwipeActionsConfiguration(actions: [favoriteAction])
        return swipeActionConfiguration
        
    }
    
    
    //MARK: - Navigation
    @IBAction func unwindToHome(segue:UIStoryboardSegue){
        dismiss(animated: true,completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetail"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationController = segue.destination as! RestaurantDetailViewController
                destinationController.restaurant = self.restaurants[indexPath.row]
            }
        }
    }
}

extension RestaurantTableViewController: NSFetchedResultsControllerDelegate{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateSnapShot()
    }
}

extension RestaurantTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let seachText = searchController.searchBar.text else{
            return
        }
        fetchRestaurantData(searchText: seachText)
    }
}
