//
//  RestaurantDiffableDataSource.swift
//  Restaurants
//
//  Created by Jamaaldeen Opasina on 16/12/2023.
//

import UIKit

enum Section{
    case all
}
class RestaurantDiffableDataSource: UITableViewDiffableDataSource<Section, Restaurant> {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
}
