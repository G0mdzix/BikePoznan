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
    
    var dataFromStationTableViewController: BikeStationViewModel!
    var stationMapVM = BikeStationMapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
        stationMapVM.setupManager()
        stationMapVM.mangager.delegate = self
            setup()
            setUpPinLocation()
     }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let userLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        updateDistance(userLocation: userLocation)
     
    }
  
    func setUpPinLocation(){
        let stationPin = MKPointAnnotation()
        self.mapKit.showsUserLocation = true
        stationPin.coordinate =  CLLocationCoordinate2D(latitude: dataFromStationTableViewController.coordinates[1], longitude: dataFromStationTableViewController.coordinates[0])
        stationPin.title = dataFromStationTableViewController.bikes
        mapKit.addAnnotation(stationPin)
        let staionPinRegion = MKCoordinateRegion(center: stationPin.coordinate, span: stationMapVM.span)
        mapKit.setRegion(staionPinRegion, animated: true)
        
    }
    
    func setup(){
        labelLabel.text = dataFromStationTableViewController.label
        bikesLabel.text = dataFromStationTableViewController.bikes
        bikeRacksLabel.text = dataFromStationTableViewController.bike_racks
    
    }
    
    func updateDistance(userLocation: CLLocation) {
        distanceLabel.text = dataFromStationTableViewController.getDistance(userLocation: userLocation)
    }
    
    

    
}

