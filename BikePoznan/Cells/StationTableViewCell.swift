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
    
    func configureCell(station: BikeStationDetailViewModel) {
        bike_racksLabel.text = station.stationData.properties.free_racks
        bikesLabel.text = station.stationData.properties.bikes
        labelLabel.text = station.stationData.properties.label
        distanceLabel.text = station.newDistance(distance: station.getDistance())
    }
    func animationOfLabels(station: BikeStationDetailViewModel){
        
        let animation = Animations()
        animation.transitionFlipFromBottom(label: distanceLabel)
        animation.changeLabelToRed(label: bikesLabel, numberOfBikes: station.stationData.properties.bikes)
    }
    
}
