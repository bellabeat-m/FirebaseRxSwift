//
//  Array+Extention.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 11/13/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import Foundation

public extension Array {
    
    /// Element at the given index if it exists.
    ///
    /// - Parameter index: index of element.
    /// - Returns: optional element (if exists).
     func item(at index: Int) -> Element? {
        
        if 0..<self.count ~= index {
            return self[index]
        }
        
        return nil
    }
    
    
    /// Return a random item from array
     func randomItem() -> Element? {
        
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self.item(at: index)
    }
}
