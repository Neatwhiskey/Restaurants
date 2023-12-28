//
//  MapViewController.swift
//  Restaurants
//
//  Created by Jamaaldeen Opasina on 25/12/2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    var restaurant = Restaurant()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
        
        //convert address to coordinate and annotate it on the map
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location, completionHandler: {placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("go")
            if let placemarks = placemarks{
                    //Get first placemark
                let placemark = placemarks[0]
                
                    //Add annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type
                
                if let location = placemark.location{
                    annotation.coordinate = location.coordinate
                    
                        //Display the annotation
                    
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
        })

        // Do any additional setup after loading the view.
    }
    
}
