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
        let childUpdates = ["\(key)" : item.toAnyObject()]
        rootRef.updateChildValues(childUpdates)
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
    }
    
 //Wrapper for Firebase db callbacks

    func listenForAllChildEvents(update: @escaping(_ snapshot: DataSnapshot?, _ error: Error?, _ eventType: DataEventType?) -> ()) {
        let taskRef = rootRef
        taskRef.observe(.childAdded, with: { (snapshot) in
             //childAdded append to array
            update(snapshot, nil, .childAdded)
            
        }) { (error) in
            update(nil, error, nil)
        }
        taskRef.observe(.childRemoved, with: { (snapshot) in
            //childRemoved delete it from the array
            update(snapshot, nil, .childRemoved)
        }) { (error) in
            update(nil, error, nil)
        }
        taskRef.observe(.childChanged, with: { (snapshot) in
            //childChanged update a row from the array
            update(snapshot, nil, .childChanged)
        }) { (error) in
            update(nil, error, nil)
        }
    }
}
