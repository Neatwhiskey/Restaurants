//
//  RestaurantDetailMapCell.swift
//  Restaurants
//
//  Created by Jamaaldeen Opasina on 25/12/2023.
//

import UIKit
import MapKit
class RestaurantDetailMapCell: UITableViewCell {

    @IBOutlet var mapView: MKMapView!{
        didSet{
            mapView.layer.cornerRadius = 20
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(location: String){
            //get location
        let geoCoder = CLGeocoder()
        
        print(location)
        // convert the address of the restaurant into coordinate using geocoder
        geoCoder.geocodeAddressString(location, completionHandler: {placemarks, error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            if let placemarks = placemarks{
                    //Get first placemark
                let placemark = placemarks[0]
                
                    // add annotation
                let annotation = MKPointAnnotation()
                
                if let location = placemark.location{
                        //Display the annotation
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    
                        //set zoom level
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
                    self.mapView.setRegion(region, animated: false)
                }
            }
        })
    }
}
