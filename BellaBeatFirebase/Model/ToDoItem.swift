//
//  ToDoItem.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 11/3/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import FirebaseDatabase

struct ToDoItem {

    var key: String
    let name: String
    var completed: Bool
    
    init(name: String, completed: Bool, key: String = "") {
        self.key = key
        self.name = name
        self.completed = completed
    }
//    func hash(into hasher: inout Hasher) {
//       hasher.combine(key.hashValue)
//    }
//    static func == (lhs: ToDoItem, rhs: ToDoItem) -> Bool {
//        return lhs.key == rhs.key
//    }
/**
  Use this method to retrieve information of DataSnapshot(Any) and create the instance.
*/
    
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
            "completed": completed,
        ]
    }
}
