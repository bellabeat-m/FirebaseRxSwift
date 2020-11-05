//
//  FireAPI.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 11/4/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import FirebaseDatabase


class FireAPI {
    
    static let shared = FireAPI()
    let taskPathAppending: DatabaseReference = Database.database().reference(withPath: "tasks")
    
    fileprivate init() { }
    
    
    func getData(completed: @escaping ([ToDoItem]) ->()) {
        
        var tasks: [ToDoItem] = []
        FireAPI.shared.taskPathAppending.observe(.value, with: { snapshot in
            for child in snapshot.children.allObjects {
                if let snapshot = child as? DataSnapshot, let task = ToDoItem(snapshot: snapshot) {
                    tasks.append(task)
                }
            }
            completed(tasks)
        })
    }
    
    func setData(with task: ToDoItem) {
        
        //var tasksMutated = tasks
//        let task = ToDoItem(name: "", completed: false)
//        let itemRef = taskDB.child(task.name)
//        itemRef.setValue(task.toAnyObject())
//        tasksMutated.append(task)
    }
    
    func removeData(with task: ToDoItem) {
        
        task.ref?.removeValue()
    }
    
}
