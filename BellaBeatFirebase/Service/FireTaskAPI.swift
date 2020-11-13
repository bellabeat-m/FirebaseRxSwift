//
//  FireTaskAPI.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 11/4/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import FirebaseDatabase


class FireTaskAPI {
    
    private var taskRef: DatabaseReference {
        return Database.database().reference(withPath: "tasks")
    }
    
    private var taskID: String? {
        return taskRef.childByAutoId().key
    }
        
     init() { }
    
    
    
    func observeData(completed: @escaping ([ToDoItem], Error?) -> Void) {
        
        taskRef.observe(.value, with: { snapshot in
            
            var tasksList:[ToDoItem] = []
            
            if snapshot.hasChildren() {
                for snap in snapshot.children {
                    
                    if let snapshot = snap as? DataSnapshot, let task = ToDoItem(snapshot: snapshot) {
                        
                        tasksList.insert(task, at: 0)
                    }
                }
            }
            completed(tasksList, nil)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func insertTask(with name: String) {
        guard let key = taskID else { return }
        
        let item = ToDoItem(name: name, completed: false, key: key)
        let taskChild = taskRef.child(key)
        taskChild.setValue(item.toAnyObject())
        
    }
        
    func removeTask(for taskKeyID: String) {
        taskRef.child(taskKeyID).removeValue()
    }
    
    func updateCheck(for task: ToDoItem) {
        taskRef.child(task.key).updateChildValues([
            "completed": task.completed
        ])
    }
    
    func removeAllObservers() {
        taskRef.removeAllObservers()
    }
}
