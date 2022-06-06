//
//  StationTableViewCell.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 21/05/2022.
//

import Foundation
import UIKit


class StationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bikesLabel: UILabel!
    @IBOutlet weak var bike_racksLabel: UILabel!
    @IBOutlet weak var labelLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    func configureCell(station: Station) {
        bike_racksLabel.text = station.properties.bike_racks
        bikesLabel.text = station.properties.bikes
        labelLabel.text = station.properties.label
    }
}
