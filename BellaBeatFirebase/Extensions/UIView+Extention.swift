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

extension UIView {
    
    /// Animate row
    ///
    /// - Parameter duration: 
    /// - Parameter delay:
    
    func animateStart(_ duration: TimeInterval, delay: TimeInterval, completion: @escaping ((Bool) -> Void)) {
        let originalX = self.frame.origin.x
        self.frame = CGRect(x: -UIScreen.main.bounds.width, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
        self.alpha = 0.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
            self.frame = CGRect(x: originalX, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
            self.alpha = 1.0
            
        }, completion: completion)
    }
    
}
