//
//  BikeStationMapViewModel.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 27/05/2022.
//

import Foundation
import CoreLocation
import MapKit




class BikeStationMapViewModel {
    let mangager = CLLocationManager()
    let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
   
}

extension BikeStationMapViewModel {
    
    func setupManager () {
        mangager.desiredAccuracy = kCLLocationAccuracyBest
        mangager.requestWhenInUseAuthorization()
        mangager.startUpdatingLocation()
    }
}




