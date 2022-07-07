//
//  AutoRoute.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 17/06/2022.
//

import Foundation
import MapKit
import CoreLocation
import RxSwift
import RxCocoa

class AutoRouting {
    
func calculateAutoRouting(userCurrentLocation: CLLocation, stationLocation: CLLocation) -> MKDirections{
    
    let sourceMapItem = MKMapItem(placemark: MKPlacemark(coordinate: userCurrentLocation.coordinate, addressDictionary: nil))
    let destinationItem = MKMapItem(placemark: MKPlacemark(coordinate: stationLocation.coordinate, addressDictionary: nil))

    let directionRequest = MKDirections.Request()
    directionRequest.source = sourceMapItem
    directionRequest.destination = destinationItem
    directionRequest.transportType = .walking
    directionRequest.requestsAlternateRoutes = true
    
    let directions = MKDirections(request: directionRequest)
    
    return MKDirections(request: directionRequest)
}
    
    
}
