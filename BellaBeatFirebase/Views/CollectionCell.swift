//
//  CollectionCell.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 11/17/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    static let identifier = "ColectionCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.backgroundColor = UIColor.clear.cgColor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
