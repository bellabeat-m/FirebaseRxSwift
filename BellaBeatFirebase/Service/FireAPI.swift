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
        FireAPI.shared.taskPathAppending.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot, let task = ToDoItem(snapshot: snapshot) {
                    tasks.append(task)
                }
            }
            completed(tasks)
        })
    }
    
    func setData(with task: ToDoItem) {
        
    }
    
    func removeData(with task: ToDoItem) {

    }
    
}
