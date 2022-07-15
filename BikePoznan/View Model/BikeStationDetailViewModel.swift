//
//  BikeStationDetailViewModel.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 14/07/2022.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

struct BikeStationDetailViewModel {
    var stationData = Station(
        geometry: StationGeometry.init(coordinates: [0,0]),
        properties: StationDetails.init(label: "abc", bikes: "90", free_racks: "80")
    )
 }

extension BikeStationDetailViewModel {
    
    func getDistance() -> Double
    {
        let disposeBag = DisposeBag()
        var localization: CLLocation!
        LocalizationHelper.singleton.currentLocation.subscribe(onNext: { (value) in
            guard let location = value else {
                return
            }
            localization = location
        }).disposed(by: disposeBag)
        let stationLocation = CLLocation(latitude: stationData.geometry.coordinates[1], longitude: stationData.geometry.coordinates[0])
        let intDistance = Double(localization.distance(from: stationLocation))
        return intDistance
    }
}

extension BikeStationDetailViewModel {

    func newDistance(distance: Double) -> String{
        if distance > 1000 {
            let stringDistanse = "► \((Double(round(distance)/1000))) km"
            return stringDistanse
        }
        else {
            let stringDistanse = "► \((Int(distance))) m"
            return stringDistanse
        }
    }
}
