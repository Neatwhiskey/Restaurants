//
//  Restaurants.swift
//  Restaurants
//
//  Created by Jamaaldeen Opasina on 05/12/2023.
//

import Foundation

struct Restaurant: Hashable {
    
    enum Rating:String{
        case awesome
        case good
        case okay
        case bad
        case terrible
        
        var image:String{
            switch self{
            case.awesome : return "love"
            case.good : return "cool"
            case.okay : return "happy"
            case.bad : return "sad"
            case.terrible : return "angry"
            }
            
        }
    }
    var name: String = ""
    var type: String = ""
    var location: String = ""
    var phone: String = ""
    var description: String = ""
    var image: String = ""
    var isFavorite: Bool = false
    var rating: Rating?
    
//    init(name: String, type: String, location: String, phone: String, description: String,image: String, isFavorite: Bool, rating: Rating) {
//        self.name = name
//        self.location = location
//        self.type = type
//        self.phone = phone
//        self.description = description
//        self.isFavorite = isFavorite
//        self.image = image
//        self.rating = rating
//    }
//    
//    init(){
//        self.init(name: "", type: "", location: "", phone: "", description: "", image: "", isFavorite: false)
//    }
}

