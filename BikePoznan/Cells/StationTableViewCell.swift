//
//  StationTableViewCell.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 21/05/2022.
//

import Foundation
import UIKit
import CoreLocation

class StationTableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var bikesLabel: UILabel!
    @IBOutlet weak var bike_racksLabel: UILabel!
    @IBOutlet weak var labelLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
   
    func configureCell(bikeStationDetail: BikeStationDetailViewModel) {
        bike_racksLabel.text = bikeStationDetail.stationData.properties.bike_racks
        bikesLabel.text = bikeStationDetail.stationData.properties.bikes
        labelLabel.text = bikeStationDetail.stationData.properties.label

    }
}
