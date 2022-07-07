//
//  Localization.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 03/06/2022.
//

import Foundation

import RxSwift
import RxCocoa
import CoreLocation

class LocalizationHelper: NSObject, CLLocationManagerDelegate  { 
    
    static let singleton = LocalizationHelper()
    
    let mangager = CLLocationManager()
    
    let currentLocationRelay: BehaviorRelay<CLLocation?> = BehaviorRelay(value: nil)
    lazy var currentLocation: Observable<CLLocation?> = self.currentLocationRelay.asObservable().share(replay: 1, scope: .forever)
    
    var completion: ((CLLocation) -> Void)?
    
     override init() {
        super.init()
        mangager.delegate = self
        mangager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        mangager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            mangager.startUpdatingLocation()
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        currentLocationRelay.accept(location)
    }
    
    
    
    
}
