//
//  UIView+Extention.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 11/13/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import UIKit


public extension UIView {
    
    /// Insert gradient
    ///
    /// - Parameter colors: list of elements
    /// - Parameter location: CGPoint of elements
 
    func applyGradient(withColors colors: [UIColor], locations: [NSNumber]? = nil) {

        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }

}
