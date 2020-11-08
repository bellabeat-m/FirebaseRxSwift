//
//  FireAPIProtocol.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 11/4/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import Foundation

protocol FireAPIProtocol {
    
    typealias TasksCompletion = ([ToDoItem]) -> Void
    
    func getData(update: @escaping TasksCompletion)
    func insertData(with task: ToDoItem, update: @escaping TasksCompletion)
    func removeData(for task: ToDoItem)
    func updateData(for task: ToDoItem)
    func removeAllObservers()
}
