//
//  FireAPIProtocol.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 11/4/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import Foundation

protocol FireAPIProtocol {

    typealias TaskCompletion = ([ToDoItem]) -> Void
    
    func getData(completed: @escaping TaskCompletion)
    func setData(with task: ToDoItem, completed: @escaping TaskCompletion)
    func removeData(with task: ToDoItem)
}
