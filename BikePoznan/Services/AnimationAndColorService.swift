//
//  AnimationAndColorService.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 14/07/2022.
//

import Foundation
import UIKit

class Animations {
    
    let green = UIColor.systemGreen
    let dark = UIColor.darkText
    let red = UIColor.systemRed
    let station = BikeStationDetailViewModel()
    
    func transitionFlipFromBottom(label: UILabel) {
        
        UIView.transition(with: label, duration: 4, options: .transitionFlipFromBottom, animations: { [self]() -> Void in
              label.textColor = dark
          }, completion: {(_ finished: Bool) -> Void in
          })

    }
    
    func changeLabelToRed(label: UILabel, numberOfBikes: String) {
        
        if Int(numberOfBikes)! <= 4
         {
            let changeColor = CATransition()
            changeColor.duration = 3
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                label.layer.add(changeColor, forKey: nil)
                label.textColor = .systemRed
            }
            label.textColor = .systemGreen
            CATransaction.commit()
         }
         else {
             label.textColor = .systemGreen
         }
    }
    
    func braknazwy(){
        /*
         var counter = station.stationData.properties.bikes {
            didSet {
              if oldValue != counter {
                print("counter was changed from \(oldValue) to \(counter)")
                  UIView.transition(with: bikesLabel, duration: 1.8, options: .transitionFlipFromBottom, animations: {() -> Void in
                        self.bikesLabel.textColor = UIColor.blue // # ifa od kolorków
                    }, completion: {(_ finished: Bool) -> Void in
                    })
              }
            }
          }
         */
    }
}
