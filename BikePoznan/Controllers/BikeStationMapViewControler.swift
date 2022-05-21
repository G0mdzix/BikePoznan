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

    
    @IBOutlet weak var Distance: UILabel!
    @IBOutlet weak var mapKit: MKMapView!
    var Coor: Array<Double> = []
    var free_bikes: String = ""
    let mangager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        mangager.desiredAccuracy = kCLLocationAccuracyBest
        mangager.delegate = self
        mangager.requestWhenInUseAuthorization()
        mangager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
 
     
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
      
        let location = locations[0]
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let userLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        
        let region = MKCoordinateRegion(center: userLocation, span: span)
    //   mapKit.setRegion(region, animated: true) //#1 wyswietanie uzytkownika
        self.mapKit.showsUserLocation = true
        
        let cordinate1 = Coor[0]
        let cordinate2 = Coor[1]
        let coordinate = CLLocationCoordinate2D(latitude: cordinate2, longitude: cordinate1)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapKit.addAnnotation(pin)
        pin.title = free_bikes
        
        let regionPin = MKCoordinateRegion(center: coordinate, span: span)
        mapKit.setRegion(regionPin, animated: true) //#2 wyswietlanie stacji rowerowej
        
  
       let UserLocDistance = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let StationLocDistance = CLLocation(latitude: cordinate2, longitude: cordinate1)
        let distance = UserLocDistance.distance(from: StationLocDistance)

        let convDistance = String(distance)
        Distance.text = convDistance+" meters"
    }

   
    
}


