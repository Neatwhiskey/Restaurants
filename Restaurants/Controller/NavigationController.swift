//
//  NavigationController.swift
//  Restaurants
//
//  Created by Jamaaldeen Opasina on 23/12/2023.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return topViewController?.preferredStatusBarStyle ?? .default
    }

}
