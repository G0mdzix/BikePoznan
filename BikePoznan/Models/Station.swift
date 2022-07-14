//
//  Stations.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 20/05/2022.
//


import Foundation
import CoreLocation

import RxSwift

struct StationsList: Codable { 
    var features: [Station]
}

struct StationDetails: Codable{
    let label, bikes, free_racks: String
}

struct StationGeometry: Codable{
    let coordinates: Array<Double>
}

struct Station: Codable{
    let geometry: StationGeometry
    let properties: StationDetails
}





