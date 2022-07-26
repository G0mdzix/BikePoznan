//
//  MapViewPins.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 21/07/2022.
//

import Foundation
import CoreLocation
import MapKit

class MapViewPins:  NSObject, MKAnnotation {
let coordinate: CLLocationCoordinate2D
let title: String?
let subtitle: String?
let image: UIImage?

init(title:String, subtitle: String, image: UIImage, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.subtitle = subtitle
    self.coordinate = coordinate
    self.image = image
    super.init()
 }
}



