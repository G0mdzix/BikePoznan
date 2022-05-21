//
//  BikeStationsTableViewController.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 20/05/2022.
//

import Foundation
import UIKit



class BikeStationsTableViewController: UITableViewController{
    
    private var stationListVM: BikeStationListViewModel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let stationVM =   self.stationListVM.stationAtIndex(indexPath.row)
       
       
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MapViewID") as? BikeStationsMapieViewController{
            vc.free_bikes = stationVM.bikes
            vc.Coor = stationVM.coordinates
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }

}
