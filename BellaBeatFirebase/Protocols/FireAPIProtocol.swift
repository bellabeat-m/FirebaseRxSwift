//
//  FireAPIProtocol.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 11/4/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import Foundation

protocol FireAPIProtocol {

    func getData(with tasks: [ToDoItem])
    func setData(with tasks: [ToDoItem])
    func removeData(with task: ToDoItem)
}
