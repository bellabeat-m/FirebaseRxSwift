//
//  ToDoItem.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 11/3/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import FirebaseDatabase

struct ToDoItem {
    
    let key: String
    let name: String
    var completed: Bool
    
    init(name: String, completed: Bool, key: String = "") {
        self.key = key
        self.name = name
        self.completed = completed
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let completed = value["completed"] as? Bool else {
                return nil
        }
        
        self.key = snapshot.key
        self.name = name
        self.completed = completed
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "completed": completed
        ]
    }
}
