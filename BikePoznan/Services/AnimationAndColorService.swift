//
//  AnimationAndColorService.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 14/07/2022.
//

import Foundation
import UIKit

struct Colors {
    
    let green = UIColor.systemGreen
    let dark = UIColor.darkText
    let white = UIColor.white
    let red = UIColor.systemRed
    let pinColor = UIColor(red: 0.75, green: 0.85, blue: 0.86, alpha: 1.00)
    let viewStackColor = UIColor(red: 0, green: 0.7098, blue: 0.749, alpha: 1.0) /* #00b5bf */
    let t = UIColor(red: 0, green: 0.6667, blue: 0.2314, alpha: 1.0) /* #00aa3b */
}

class Animations {
    
    let station = BikeStationDetailViewModel()
    
    func transitionFlipFromBottom(label: UILabel, color: UIColor) {
        UIView.transition(with: label, duration: 4, options: .transitionFlipFromBottom, animations: { [self]() -> Void in
            label.textColor = color
          }, completion: {(_ finished: Bool) -> Void in
          })

    }
    
    func changeLabelToRed(label: UILabel, numberOfBikes: String) {
        
        let numberOfBikesWhenAnimationWillBegin = 4
        if Int(numberOfBikes)! <= numberOfBikesWhenAnimationWillBegin
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
  
}


