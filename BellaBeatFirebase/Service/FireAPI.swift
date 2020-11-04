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
    let taskDB: DatabaseReference = Database.database().reference(withPath: "tasks")
    
    fileprivate init() { }
    
    // childURL = nil returns the root of the database
    // childURL can contain multiple subdirectories separated with a slash: "one/two/three"
    func getData(_ childURL: String?, completionHandler: @escaping (Any?) -> ()) {
        var reference = self.taskDB
        if let url = childURL{
            reference = self.taskDB.child(url)
        }
        reference.observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
            completionHandler(snapshot.value)
        }
    }
}
