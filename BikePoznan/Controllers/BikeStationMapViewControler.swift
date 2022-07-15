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
    
    let animation = Animations()
    var station: BikeStationDetailViewModel!
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
        LocalizationHelper.singleton.currentLocation.subscribe(onNext: { [self] (value) in
            guard let location = value else {
                return
            }
            distanceLabel.text = station.newDistance(distance: self.station.getDistance())
            animation.transitionFlipFromBottom(label: distanceLabel)
            animation.changeLabelToRed(label: bikesLabel, numberOfBikes: station.stationData.properties.bikes)
        }).disposed(by: bag)
    }

    func setUpPinLocation(){
        let stationPin = MKPointAnnotation()
        self.mapKit.showsUserLocation = true
        stationPin.coordinate =  CLLocationCoordinate2D(latitude: station.stationData.geometry.coordinates[1], longitude: station.stationData.geometry.coordinates[0])
        stationPin.title = station.stationData.properties.bikes
        mapKit.addAnnotation(stationPin)
    }
    
    func setupLabels() {
        labelLabel.text = station.stationData.properties.label
        bikesLabel.text = station.stationData.properties.bikes
        bikeRacksLabel.text = station.stationData.properties.free_racks
     
    }
 
    func getRoute(){
        
        LocalizationHelper.singleton.currentLocation.subscribe(onNext: { [self] (value) in
            autoRouting.calculateAutoRouting(userCurrentLocation: value!, stationLocation: CLLocation(latitude: self.station.stationData.geometry.coordinates[1], longitude: station.stationData.geometry.coordinates[0]),mapKit: mapKit)
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

