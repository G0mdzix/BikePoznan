//
//  Stations.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 20/05/2022.
//


import Foundation
import CoreLocation

struct StationsList: Codable { 
    let features: [Station]
}

struct StationDetails: Codable{
    let label, bikes, bike_racks: String
}

struct StationGeometry: Codable{
    let coordinates: Array<Double>
}

struct Station: Codable{
    let geometry: StationGeometry
    let properties: StationDetails
}

extension Station {
  
    func getDistance(userLocation: CLLocation) -> String
    {
        let stationLocation = CLLocation(latitude: geometry.coordinates[1], longitude: geometry.coordinates[0])
        let distance = userLocation.distance(from: stationLocation)
        if distance > 1000 {
            let convertedDistanceToString = "► \(String(Double(round(distance)/1000))) km"
            return convertedDistanceToString
        } else {
            let convertedDistanceToString = "► \(String(Int(distance))) m"
            return convertedDistanceToString
        }
    }
}
