//
//  BikeStationsTableViewController.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 20/05/2022.
//

import Foundation
import UIKit
import CoreLocation


class BikeStationsTableViewController: UITableViewController, CLLocationManagerDelegate{
    
    private var stationListVM: BikeStationListViewModel!

    var stationMapVM = BikeStationMapViewModel()
       
    var userLocation: CLLocation = CLLocation(latitude: 0, longitude: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        stationMapVM.setupManager()
       stationMapVM.mangager.delegate = self
        setup()
    }
    func setup(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let url = URL(string: "http://www.poznan.pl/mim/plan/map_service.html?mtype=pub_transport&co=stacje_rowerowe")!
        
        Webservice().getBikeStations(url: url) { station in
            
            if let station = station{
                self.stationListVM = BikeStationListViewModel(Station: station)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                 
            }
        
    }
}
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        let location = locations[0]
   
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        userLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
       return
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.stationListVM == nil ? 0 : self.stationListVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stationListVM.numberOfRowsInSection(section)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StationTableViewCell", for: indexPath) as? StationTableViewCell else {
            fatalError("Cell not found")
            
        }
        
        let stationVM =   self.stationListVM.stationAtIndex(indexPath.row)
        cell.bike_racksLabel.text = stationVM.bike_racks
        cell.bikesLabel.text = stationVM.bikes
        cell.labelLabel.text = stationVM.label
        cell.distanceLabel.text = stationVM.getDistance(userLocation: userLocation)
        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if let goToMapView = storyboard?.instantiateViewController(withIdentifier: "MapViewID") as? BikeStationsMapieViewController{
            goToMapView.dataFromStationTableViewController = self.stationListVM.stationAtIndex(indexPath.row)
            self.navigationController?.pushViewController(goToMapView, animated: true)
        }
       
     
    }
     
     
}
