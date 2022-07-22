//
//  StackViewExtensions.swift
//  BikePoznan
//
//  Created by Mateusz Gozdzik on 22/07/2022.
//

import Foundation
import UIKit

extension UIStackView {
func insertCustomizedViewIntoStack(background: UIColor, cornerRadius: CGFloat, shadowColor: CGColor, shadowOpacity: Float, shadowRadius: CGFloat) {
        let subView = UIView(frame: bounds)
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subView.layer.cornerRadius = cornerRadius
        subView.backgroundColor = background
        subView.layer.shadowColor = shadowColor
        subView.layer.shadowOpacity = shadowOpacity
        subView.layer.shadowOffset = .zero
        subView.layer.shadowRadius = shadowRadius
        insertSubview(subView, at: 0)
    }
}
