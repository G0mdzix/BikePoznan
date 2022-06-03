//
//  Localization.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 03/06/2022.
//

import Foundation
import CoreLocation

class Localization: NSObject, CLLocationManagerDelegate {
    static let shared = Localization()
    static let shared2 = Localization()

    let mangager = CLLocationManager()
    
    var completion: ((CLLocation) -> Void)?
    
    public func getUserLocation(completion: @escaping ((CLLocation) -> Void)){
        self.completion = completion
        mangager.requestWhenInUseAuthorization()
        mangager.delegate = self
        mangager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        completion?(location)
    }
    
    
}
