//
//  Stations.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 20/05/2022.
//


import Foundation

struct StationsList: Decodable{
    let features: [Stations]
}

struct StationDetails: Decodable{
    let label, bikes, bike_racks: String
}

struct StationGeometry: Decodable{
    let coordinates: Array<Double>
}



struct Stations: Decodable{
    let geometry: StationGeometry
    let properties: StationDetails
}



