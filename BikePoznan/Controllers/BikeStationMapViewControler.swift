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
import RxSwift
import RxCocoa

class BikeStationsMapieViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var labelLabel: UILabel!
    @IBOutlet weak var bikesLabel: UILabel!
    @IBOutlet weak var bikeRacksLabel: UILabel!
    @IBOutlet weak var mapKit: MKMapView!
    
    var station: Station!
    fileprivate let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        setUpPinLocation()
        bindLocation()
    }
    
    func bindLocation() {
        LocalizationHelper.singleton.currentLocation.subscribe(onNext: { (value) in
            guard let location = value else {
                return
            }
            self.updateDistance(userLocation: location)
        }).disposed(by: bag)
    }

    func setUpPinLocation(){
        let stationPin = MKPointAnnotation()
        self.mapKit.showsUserLocation = true
        stationPin.coordinate =  CLLocationCoordinate2D(latitude: station.geometry.coordinates[1], longitude: station.geometry.coordinates[0])
            stationPin.title = station.properties.bikes
        mapKit.addAnnotation(stationPin)
        let staionPinRegion = MKCoordinateRegion(center: stationPin.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapKit.setRegion(staionPinRegion, animated: true)
    }
    
    func setupLabels() {
            labelLabel.text = station.properties.label
            bikesLabel.text = station.properties.bikes
            bikeRacksLabel.text = station.properties.bike_racks
    }
 
    func updateDistance(userLocation: CLLocation) {
            distanceLabel.text = station.getDistance(userLocation: userLocation)
     }
}

