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
    var imageURL: String?
    
    init(name: String, completed: Bool, key: String = "", imageURL: String?) {
        self.key = key
        self.name = name
        self.completed = completed
        self.imageURL = imageURL
    }

/**
  Use this method to retrieve information of DataSnapshot(Any) and create the instance.
*/
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let completed = value["completed"] as? Bool,
            let imageURL = value["imageURL"] as? String else {
                return nil
        }
        
        self.key = snapshot.key
        self.name = name
        self.completed = completed
        self.imageURL = imageURL
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "completed": completed,
            "imageURL": imageURL as Any
        ]
    }
}
