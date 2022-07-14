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


class BikeStationViewModel {
    
    var stations: Observable<[Station]>?
    private let disposeBag = DisposeBag()
    let webservice = Webservice()
    private let bikeStationsList = BehaviorRelay<[BikeStationDetailViewModel]>(value: []) 
    var bikeStationsListObserver: Observable<[BikeStationDetailViewModel]> {
           return bikeStationsList.asObservable()
            .map({ (items) -> [BikeStationDetailViewModel] in
                   return items.sorted(by: { (item1, item2) -> Bool in
                       return item1.getDistance() < item2.getDistance()
                   })
               })
       }
 
    func fetchUserList() {
       
             stations = webservice.getBikeStations()
             stations?.subscribe(onNext: { (value) in
                 var bikeViewModelArray = [BikeStationDetailViewModel]()
                 for index in 0..<value.count {
                     var station = BikeStationDetailViewModel()
                     station.stationData = value[index]
                     bikeViewModelArray.append(station)
                 }
                 self.bikeStationsList.accept(bikeViewModelArray)
             }, onError: { (error) in
                 _ = self.bikeStationsList.catchError { (error) in
                     Observable.empty()
                 }
                 print(error.localizedDescription)
             }).disposed(by: disposeBag)
         }
}



