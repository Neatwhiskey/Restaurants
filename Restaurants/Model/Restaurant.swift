//
//  Restaurants.swift
//  Restaurants
//
//  Created by Jamaaldeen Opasina on 05/12/2023.
//

import Foundation

struct Restaurant: Hashable {
    var name: String = ""
    var type: String = ""
    var location: String = ""
    var phone: String = ""
    var description: String = ""
    var image: String = ""
    var isFavorite: Bool = false
    
    init(name: String, type: String, location: String, phone: String, description: String,image: String, isFavorite: Bool) {
        self.name = name
        self.location = location
        self.type = type
        self.phone = phone
        self.description = description
        self.isFavorite = isFavorite
        self.image = image
    }
    
    init(){
        self.init(name: "", type: "", location: "", phone: "", description: "", image: "", isFavorite: false)
    }
}

