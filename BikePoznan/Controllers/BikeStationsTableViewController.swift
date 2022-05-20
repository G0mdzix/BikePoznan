//
//  BikeStationsTableViewController.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 20/05/2022.
//

import Foundation
import UIKit

class BikeStationsTableViewController: UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    func setup(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let url = URL(string: "http://www.poznan.pl/mim/plan/map_service.html?mtype=pub_transport&co=stacje_rowerowe")!
        
        Webservice().getBikeStations(url: url) { _ in
            
        }
        
    }
}
