//
//  BikeViewModel.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 31/05/2022.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

struct BikeStationDetailViewModel {
    var stationData = Stations(geometry: StationGeometry.init(coordinates: [0,0]), properties: StationDetails.init(label: "abc", bikes: "90", bike_racks: "80"))
}

class BikeStationViewModel {
    
    let request = Webservice()
    var stations: Observable<[Stations]>?
       private let bikeStationViewModel = BehaviorRelay<[BikeStationDetailViewModel]>(value: [])
       var bikeStationViewModelObserver: Observable<[BikeStationDetailViewModel]> {
           return bikeStationViewModel.asObservable()
       }
 
    private let disposeBag = DisposeBag()
    
    func fetchUserList() {
        stations = request.getBikeStations() 
        stations?.subscribe(onNext: { (value) in
            var bikeViewModelArray = [BikeStationDetailViewModel]()
            for index in 0..<value.count {
                var station = BikeStationDetailViewModel()
                station.stationData = value[index]
                bikeViewModelArray.append(station)
            }
            self.bikeStationViewModel.accept(bikeViewModelArray)
        }, onError: { (error) in
            _ = self.bikeStationViewModel.catchError { (error) in
                Observable.empty()
            }
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}


extension BikeStationDetailViewModel {
  
    func getDistance(userLocation: CLLocation) -> String
    {
        let stationLocation = CLLocation(latitude: stationData.geometry.coordinates[1], longitude: stationData.geometry.coordinates[0])
        let distance = userLocation.distance(from: stationLocation)
               let convertedDistanceToString = String(Int(distance))
               return convertedDistanceToString+" meters"
    }
}



