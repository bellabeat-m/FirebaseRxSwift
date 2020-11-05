//
//  FireAPI.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 11/4/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import FirebaseDatabase


class FireAPI: FireAPIProtocol {
    
    static let shared = FireAPI()
    var databaseRef: DatabaseReference?
    fileprivate init() { }
    
    func getData(completed: @escaping ([ToDoItem]) ->()) {
        databaseRef = Database.database().reference(withPath: "tasks")
        var tasks: [ToDoItem] = []
        databaseRef?.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot, let task = ToDoItem(snapshot: snapshot) {
                    tasks.append(task)
                }
            }
            completed(tasks)
        })
    }
    
    func setData(with task: ToDoItem, completed: @escaping ([ToDoItem]) ->()) {
        var tasks: [ToDoItem] = []
        databaseRef = Database.database().reference(withPath: "tasks")
        let itemRef = databaseRef?.child(task.name)
        itemRef?.setValue(task.toAnyObject())
        tasks.append(task)
        completed(tasks)
        
    }
    
    func removeData(with task: ToDoItem) {

    }
    
}
