//
//  Webservice.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 20/05/2022.
//

import Foundation
import RxCocoa
import RxSwift

class Webservice{
    let url = URL(string: "http://www.poznan.pl/mim/plan/map_service.html?mtype=pub_transport&co=stacje_rowerowe")!
    let session = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask? = nil
  
    func getBikeStations<T: Codable>() -> Observable<T> {
        return Observable<T>.create { observer in
            self.dataTask = self.session.dataTask(with: self.url, completionHandler: {
                (data, response, error) in
            do {
                var stationListModel: StationsList = try! JSONDecoder().decode(StationsList.self, from: data
                    ?? Data())
             //   stationListModel.features.sort(by: {$0.properties.bikes > $1.properties.bikes})
                observer.onNext(stationListModel.features as! T)
            } catch let error {
                observer.onError(error)
            }
            observer.onCompleted()
            })
            self.dataTask?.resume()
            return Disposables.create {
                self.dataTask?.cancel()
            }
        }
    }
}

