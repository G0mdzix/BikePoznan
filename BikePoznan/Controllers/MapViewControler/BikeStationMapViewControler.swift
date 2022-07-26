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
import SwiftUI

class BikeStationsMapieViewController: UIViewController {

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var labelLabel: UILabel!
    @IBOutlet weak var bikesLabel: UILabel!
    @IBOutlet weak var bikeRacksLabel: UILabel!
    @IBOutlet weak var mapKit: MKMapView!
    @IBOutlet weak var segmentControler: UISegmentedControl!
    @IBOutlet weak var stackView_1: UIStackView!
    @IBOutlet weak var stackView_2: UIStackView!
    
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
        setUpView()
        segmentControler.addTarget(self, action: #selector(switchType), for: .valueChanged)
        self.mapKit.delegate = self
        self.mapKit.showsUserLocation = true
    }
    
    
    func bindLocation() {
        LocalizationHelper.singleton.currentLocation.subscribe(onNext: { [self] (value) in
            guard let location = value else {
                return
            }
            distanceLabel.text = station.newDistance(distance: self.station.getDistance())
            animation.transitionFlipFromBottom(label: distanceLabel, color: Colors().white)
            animation.changeLabelToRed(label: bikesLabel, numberOfBikes: station.stationData.properties.bikes)
        }).disposed(by: bag)
    }

    func setUpPinLocation(){
        let stationPin = MapViewPins.init(title: station.stationData.properties.label, subtitle: station.stationData.properties.bikes, image: UIImage(named: "Icon_2")!, coordinate: CLLocationCoordinate2D(latitude: station.stationData.geometry.coordinates[1], longitude: station.stationData.geometry.coordinates[0]))
        mapKit.addAnnotation(stationPin)
    
    }
    
    
    func setupLabels() {
        labelLabel.text = station.stationData.properties.label
        bikesLabel.text = station.stationData.properties.bikes
        bikeRacksLabel.text = station.stationData.properties.free_racks
  
    }
    func setUpView(){
        view.setGradientBackground(colorOne: UIColor(named: "Background 1")!, colorTwo: UIColor(named: "Background 2")!)
        stackView_1.customize(backgroundColor: UIColor(named: "WidgetColor")!, radiusSize: 40)
        stackView_2.customize(backgroundColor: UIColor(named: "WidgetColor")!, radiusSize: 40)
    }
    func getRoute(){
        
        LocalizationHelper.singleton.currentLocation.subscribe(onNext: { [self] (value) in
            autoRouting.calculateAutoRouting(userCurrentLocation: value!, stationLocation: CLLocation(latitude: self.station.stationData.geometry.coordinates[1], longitude: station.stationData.geometry.coordinates[0]),mapKit: mapKit)
        }).disposed(by: bag)
    }
}


