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
    
    private var tasksList = [ToDoItem]()
    var taskAddedIndex = 0
    
    fileprivate init() { }
    
    func getData(update: @escaping ([ToDoItem], Error?) -> Void) {
        
        rootRef.observeSingleEvent(of: .value, with: { snapshot in
            
            self.tasksList.removeAll()
            
            if snapshot.hasChildren() {
                for snap in snapshot.children {
                    
                    if let snapshot = snap as? DataSnapshot, let task = ToDoItem(snapshot: snapshot) {
                        self.tasksList.append(task)
                    }
                }
            }
            update(self.tasksList, nil)
        }) {
            (error) in
            print(error.localizedDescription)
        }
    }
    
    func insertTaskData(with name: String, update: @escaping ([ToDoItem]) -> Void) {
        guard let key = taskKey else { return }
        
        let item = ToDoItem(name: name, completed: false, key: key)
        let taskRef = rootRef.child(key)
        taskRef.setValue(item.toAnyObject())
        self.tasksList.insert(item, at: 0)
        
        update(self.tasksList)
    }
        
    func removeData(for taskKeyID: String) {
        rootRef.child(taskKeyID).removeValue()
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
    

//Wrapper
    func listenForAllChildEvents(with name: String?, update: @escaping(_ snapshot: DataSnapshot?, _ error: Error?, _ eventType: DataEventType?) -> ()) {
        let taskRef = rootRef
        taskRef.observe(.childAdded, with: { (snapshot) in
            //childAdded append to array
            guard let key = self.taskKey else { return }
            let item = ToDoItem(name: name ?? "", completed: false)
            let childUpdates = ["\(key)" : item.toAnyObject()]
            self.rootRef.updateChildValues(childUpdates)
            self.tasksList.insert(item, at: 0)
            update(snapshot, nil, .childAdded)
            
        }) { (error) in
            update(nil, error, nil)
        }
        taskRef.observe(.childRemoved, with: { (snapshot) in
            //childRemoved delete it from the array
            if let index = self.tasksList.firstIndex(where: {$0.key == snapshot.key}) {
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot, let task = ToDoItem(snapshot: snapshot) {
                    self.tasksList.remove(at: index)
                    self.rootRef.child(task.key).removeValue { error, _  in
                        if error != nil {
                            print("error \(String(describing: error?.localizedDescription))")
                        }
                    }
                }
            }
        }
            update(snapshot, nil, .childRemoved)
        }) { (error) in
            update(nil, error, nil)
        }
        taskRef.observe(.childChanged, with: { (snapshot) in
            //childChanged update a row from the array
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot, let task = ToDoItem(snapshot: snapshot) {
                    self.rootRef.child(task.key).updateChildValues([
                        "completed": task.completed
                    ])
                }
            }
            update(snapshot, nil, .childChanged)
        }) { (error) in
            update(nil, error, nil)
        }
    }
}
