//
//  AutoRoute.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 17/06/2022.
//

import Foundation
import MapKit
import CoreLocation


class AutoRouting {
    
    func calculateAutoRouting(userCurrentLocation: CLLocation, stationLocation: CLLocation, mapKit: MKMapView) {
    
    let sourceMapItem = MKMapItem(placemark: MKPlacemark(coordinate: userCurrentLocation.coordinate, addressDictionary: nil))
    let destinationItem = MKMapItem(placemark: MKPlacemark(coordinate: stationLocation.coordinate, addressDictionary: nil))

    let directionRequest = MKDirections.Request()
    directionRequest.source = sourceMapItem
    directionRequest.destination = destinationItem
    directionRequest.transportType = .walking
    directionRequest.requestsAlternateRoutes = true
    
    let directions = MKDirections(request: directionRequest)
    
    directions.calculate { (response, error) in
           guard let response = response else {
               if let error = error {
                   print("ERROR FOUND : \(error.localizedDescription)")
               }
               return
           }
           let route = response.routes[0]
   
        if(mapKit.overlays.count > 0)
        {
            for route in mapKit.overlays
        {
                mapKit.removeOverlay(route)
               
        }}
        mapKit.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
        mapKit.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0), animated: true)
     

}
    
}
    
    
}
