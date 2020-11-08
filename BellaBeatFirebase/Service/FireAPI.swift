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
    
    var rootRef: DatabaseReference {
        return Database.database().reference(withPath: "tasks")
    }
    var taskKey: String? {
        return rootRef.childByAutoId().key
    }
    
    var tasksList = [ToDoItem]()
//TOFIX: need this to set observers once in UI?
    var didGetTaskData = false
    
    fileprivate init() { }
    
    func getData(update: @escaping ([ToDoItem]) -> Void) {
        
        rootRef.observeSingleEvent(of: .value, with: { snapshot in
            self.tasksList.removeAll()
            self.tasksList = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot, let task = ToDoItem(snapshot: snapshot) {
                    self.tasksList.append(task)
                }
            }
            update(self.tasksList)
        }) {
            (error) in
            print(error.localizedDescription)
        }
    }
    
    func insertData(with name: String, update: @escaping ([ToDoItem]) -> Void) {
        guard let key = taskKey else { return }
        let item = ToDoItem(name: name, completed: false)
        let itemRef = self.rootRef.child(key)
        itemRef.setValue(item.toAnyObject())
        self.tasksList.insert(item, at: 0)        
        update(self.tasksList)
        
    }
        
    func removeData(for task: ToDoItem) {
        rootRef.child(task.key).removeValue()
    }
    
    func updateData(for task: ToDoItem) {
        rootRef.child(task.key).updateChildValues([
            "completed": task.completed
        ])
    }
    
    func removeAllObservers() {
        tasksList.removeAll()
        rootRef.childByAutoId().removeAllObservers()
        didGetTaskData = false
    }
}
