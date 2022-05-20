//
//  BikeStationViewModel.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 21/05/2022.
//

import Foundation

struct BikeStationListViewModel{
    let Station: [Stations]
}

extension BikeStationListViewModel{
    
    var numberOfSections: Int {
        return 1
    }
    func numberOfRowsInSection (_ section: Int) -> Int{
        return self.Station.count
    }
    func stationAtIndex(_ index: Int) -> BikeStationViewModel {
        let station = self.Station[index]
        return BikeStationViewModel(station)
    }
}

struct BikeStationViewModel {
    private let Station: Stations
    
}

extension BikeStationViewModel{
    init(_ station: Stations){
        self.Station = station
    }
}

extension BikeStationViewModel{
        var label: String{
            return self.Station.properties.label
        }
    }
extension BikeStationViewModel{
    var bikes: String{
        return self.Station.properties.bikes
    }
}

extension BikeStationViewModel{
        var bike_racks: String{
            return self.Station.properties.bike_racks
        }
    }
