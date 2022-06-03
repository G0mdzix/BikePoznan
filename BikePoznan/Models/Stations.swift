//
//  Stations.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 20/05/2022.
//


import Foundation

struct StationsList: Codable { 
    let features: [Stations]
}

struct StationDetails: Codable{
    let label, bikes, bike_racks: String
}

struct StationGeometry: Codable{
    let coordinates: Array<Double>
}



struct Stations: Codable{
    let geometry: StationGeometry
    let properties: StationDetails
}



