//
//  BikeStationMapViewControler.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 21/05/2022.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class BikeStationsMapieViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var labelLabel: UILabel!
    @IBOutlet weak var bikesLabel: UILabel!
    @IBOutlet weak var bikeRacksLabel: UILabel!
    @IBOutlet weak var mapKit: MKMapView!
    
    var racks: String = ""
    var bikes: String = ""
    var streetLabel: String = ""
    
    var coordinates: Array<Double> = []
    var freeBikes: String = ""
    let mangager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        mangager.desiredAccuracy = kCLLocationAccuracyBest
        mangager.delegate = self
        mangager.requestWhenInUseAuthorization()
        mangager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
 
     
        let location = locations[0] //!
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let userLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        
        let region = MKCoordinateRegion(center: userLocation, span: span)
       mapKit.setRegion(region, animated: true)
        self.mapKit.showsUserLocation = true
        
        let longitudePin = coordinates[0]
        let latidudePin = coordinates[1]
        let coordinate = CLLocationCoordinate2D(latitude: latidudePin, longitude: longitudePin)
        
        let stationPin = MKPointAnnotation()
        stationPin.coordinate = coordinate
        stationPin.title = freeBikes
        mapKit.addAnnotation(stationPin)
        
        let regionPin = MKCoordinateRegion(center: coordinate, span: span)
        mapKit.setRegion(regionPin, animated: true)
        
  
       let userLoc = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let stationLoc = CLLocation(latitude: latidudePin, longitude: longitudePin)
        let distance = userLoc.distance(from: stationLoc)
        let convertedDistanceToString = String(Int(distance))
        
        distanceLabel.text = convertedDistanceToString+" meters"
        labelLabel.text = streetLabel
        bikesLabel.text = bikes
        bikeRacksLabel.text = racks
   
      
    }

   
    
}


