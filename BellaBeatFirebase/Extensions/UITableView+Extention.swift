//
//  UITableView+Extention.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 11/13/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//
import  UIKit

extension UITableView {
    func dequeueCell<T: UITableViewCell>(withIdentifier identifier: String) -> T? {
        return dequeueReusableCell(withIdentifier: identifier) as? T
    }
}
