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

struct Stations: Decodable{

    let properties: StationDetails
  
}



