//
//  Webservice.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 20/05/2022.
//

import Foundation

class Webservice{
   
   
    func getBikeStations(url: URL, completeion: @escaping([Stations]?) -> ()){
        
        URLSession.shared.dataTask(with: url){ data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
              
            } else if let data = data {
               
                let stationList = try? JSONDecoder().decode(StationsList.self, from: data)
                
                if let stationList = stationList{
                    completeion(stationList.features)
                }
           
              
                
            }
            
        }.resume()
        
    }
    
}
