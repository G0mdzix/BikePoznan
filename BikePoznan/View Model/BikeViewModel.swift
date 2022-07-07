//
//  BikeViewModel.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 31/05/2022.
//

import Foundation
import RxSwift
import RxCocoa



class BikeStationViewModel {
    
    let webservice = Webservice()
    private let bikeStationsList = BehaviorRelay<[Station]>(value: [])
    var bikeStationsListObserver: Observable<[Station]> {
           return bikeStationsList.asObservable()
       }
 
    private let disposeBag = DisposeBag()
    
  
    func fetchUserList() {
        webservice.getBikeStations().subscribe(onNext: { (value) in
            self.bikeStationsList.accept(value)
        }, onError: { (error) in
            _ = self.bikeStationsList.catchError { (error) in
                Observable.empty()
            }
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
}
