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
    
    var databaseRef: DatabaseReference {
        return Database.database().reference().child("tasks")
    }
    
    var taskList: [ToDoItem] = []
//TOFIX: need this to set observers once in UI?
    var didGetTaskData = false
    
    fileprivate init() { }
    
    func getData(update: @escaping ([ToDoItem]) -> Void) {
        
        databaseRef.observeSingleEvent(of: .value, with: { snapshot in
            self.taskList.removeAll()
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot, let task = ToDoItem(snapshot: snapshot) {
                    self.taskList.append(task)
                }
            }
            update(self.taskList)
        }) {
            (error) in
            print(error.localizedDescription)
        }
    }
    
    func setData(with name: String, update: @escaping ([ToDoItem]) -> Void) {
        
        guard let taskName = databaseRef.childByAutoId().key else { return }
        let item = ToDoItem(name: name, completed: false)
        let itemRef = self.databaseRef.child(taskName)
        itemRef.setValue(item.toAnyObject())
        self.taskList.append(item)
        update(self.taskList)
        
    }
        
    func removeData(for task: ToDoItem) {
        databaseRef.child(task.name).removeValue()
    }
    
    func updateData(for task: ToDoItem) {
        databaseRef.child(task.name).updateChildValues([
            "completed": task.completed
        ])
    }
    
    func removeAllObservers() {
        taskList.removeAll()
        databaseRef.childByAutoId().removeAllObservers()
        didGetTaskData = false
    }
}
