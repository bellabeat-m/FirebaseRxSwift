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
    let taskDB: DatabaseReference = Database.database().reference(withPath: "tasks")
    
    fileprivate init() { }
    
    
    func getData(with tasks: [ToDoItem]) {
        
        var tasksMutated = tasks
        FireAPI.shared.taskDB.observe(.value, with: { snapshot in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot, let task = ToDoItem(snapshot: snapshot) {
                    tasksMutated.append(task)
                }
            }
        })
    }
    
    func setData(with tasks: [ToDoItem]) {
        
        var tasksMutated = tasks
        let task = ToDoItem(name: "", completed: false)
        let itemRef = taskDB.child(task.name)
        itemRef.setValue(task.toAnyObject())
        tasksMutated.append(task)
    }
    
    func removeData(with task: ToDoItem) {
        
        task.ref?.removeValue()
    }
    
}
