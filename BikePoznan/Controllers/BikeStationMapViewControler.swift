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
    
    private let disposeBag = DisposeBag()
     var stationDetail = BehaviorRelay<BikeStationDetailViewModel>(value: BikeStationDetailViewModel())
     var stationDetailObservel: Observable<BikeStationDetailViewModel> {
         return stationDetail.asObservable()
     }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setUpPinLocation()
        Localization.shared2.getUserLocation { [weak self] location in
            DispatchQueue.main.async { [self] in
                guard self != nil else {
                    return
                }
                self?.updateDistance(userLocation: location)
            }
        }
    }

    func setUpPinLocation(){
        
        let stationPin = MKPointAnnotation()
        self.mapKit.showsUserLocation = true
        stationDetailObservel.subscribe(onNext: { (stationValue) in
            stationPin.coordinate =  CLLocationCoordinate2D(latitude: stationValue.stationData.geometry.coordinates[1], longitude: stationValue.stationData.geometry.coordinates[0])
            stationPin.title = stationValue.stationData.properties.bikes
        }).disposed(by: disposeBag)
        mapKit.addAnnotation(stationPin)
        let staionPinRegion = MKCoordinateRegion(center: stationPin.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapKit.setRegion(staionPinRegion, animated: true)
    }
    
    func setup(){
        
        stationDetailObservel.subscribe(onNext: { [self] (stationValue) in
            labelLabel.text = stationValue.stationData.properties.label
            bikesLabel.text = stationValue.stationData.properties.bikes
            bikeRacksLabel.text = stationValue.stationData.properties.bike_racks
        }).disposed(by: disposeBag)
    }
 
    func updateDistance(userLocation: CLLocation) {
       
         stationDetailObservel.subscribe(onNext: { [self]  (stationValue) in
            distanceLabel.text = stationValue.getDistance(userLocation: userLocation)
         }).disposed(by: disposeBag)
     }
}

