//
//  MapViewControllerExtension.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 22/07/2022.
//

import Foundation
import UIKit
import MapKit

extension BikeStationsMapieViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
         let renderer = MKPolylineRenderer(overlay: overlay)
         renderer.strokeColor = UIColor.red
         renderer.lineWidth = 5.0
         return renderer
    }
    
   func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let myAnnotation = annotation as? MapViewPins  else {
            return nil
        }
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = myAnnotation.image?.withBackground(color: Colors().pinColor).roundedImage()
           
        }
        return annotationView
    }
    
    @objc func switchType() {
        switch segmentControler.selectedSegmentIndex {
        case 0:
            mapKit.mapType = .standard
        case 1:
            mapKit.mapType = .satellite
        case 2:
            mapKit.mapType = .hybrid
        default:
            return
        }
    }
}
