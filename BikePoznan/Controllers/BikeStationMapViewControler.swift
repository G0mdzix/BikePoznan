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

class BikeStationsMapieViewController: UIViewController {

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var labelLabel: UILabel!
    @IBOutlet weak var bikesLabel: UILabel!
    @IBOutlet weak var bikeRacksLabel: UILabel!
    @IBOutlet weak var mapKit: MKMapView!
    @IBOutlet weak var centerButton: UIButton!
    
    var station: Station!
    fileprivate let bag = DisposeBag()
    var autoRouting = AutoRouting()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        setUpPinLocation()
        bindLocation()
        getRoute()
        self.mapKit.delegate = self
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
    }
    
    func setupLabels() {
            labelLabel.text = station.properties.label
            bikesLabel.text = station.properties.bikes
            bikeRacksLabel.text = station.properties.bike_racks
    }
 
    func updateDistance(userLocation: CLLocation) {
            distanceLabel.text = station.getDistance(userLocation: userLocation)
     }
    
    func getRoute(){
        
        LocalizationHelper.singleton.currentLocation.subscribe(onNext: { [self] (value) in
            let directions =  autoRouting.calculateAutoRouting(userCurrentLocation: value!, stationLocation: CLLocation(latitude: self.station.geometry.coordinates[1], longitude: station.geometry.coordinates[0]))
            directions.calculate { (response, error) in
                   guard let response = response else {
                       if let error = error {
                           print("ERROR FOUND : \(error.localizedDescription)")
                       }
                       return
                   }
                   let route = response.routes[0]
           
                if(self.mapKit.overlays.count > 0)
                {
                    for route in self.mapKit.overlays
                {
                        self.mapKit.removeOverlay(route)
                }}
                self.mapKit.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
                self.mapKit.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0), animated: true)
    
    }
        }).disposed(by: bag)
    }
}

extension BikeStationsMapieViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
         let renderer = MKPolylineRenderer(overlay: overlay)
         renderer.strokeColor = UIColor.red
         renderer.lineWidth = 5.0
         return renderer
    }
}
