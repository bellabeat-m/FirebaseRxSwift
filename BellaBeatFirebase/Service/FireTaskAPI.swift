//
//  FireTaskAPI.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 11/4/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import FirebaseDatabase
import FirebaseStorage


class FireTaskAPI {
    
    private let storage = Storage.storage()
    
    private var taskRef: DatabaseReference {
        return Database.database().reference(withPath: "tasks")
    }
    
    private var taskID: String? {
        return taskRef.childByAutoId().key
    }
    
    init() { }
    
    // MARK: OBSERVE
    
    /**
     Asynchronously observe all chages of the object at the FirebaseDatabase.
     
     @param block to create DB Object
     */
    
    
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
    
    // MARK: UPLOAD
    
    /**
     Asynchronously upload the object at the FB
     
     @param key Unique key to be observed
     */
    
    func insertTask(with name: String) {
        
        guard let key = taskID else { return }
        
        let item = ToDoItem(name: name, completed: false, key: key, imageURL: "")
        let taskChild = taskRef.child(key)
        taskChild.setValue(item.toAnyObject())
        
    }
    
    // MARK: DELETE
    
    /**
     Asynchronously deltet the object at the FBDatabase.
     
     @param key Unique key to be remove or sorted
     */
    
    func removeTask(for taskKeyID: String) {
        
        taskRef.child(taskKeyID).removeValue()
    }
    
    // MARK: UPDATE
    
    /**
     Asynchronously updates the object at the FBDatabase.
     An NSData of the provided max size will be allocated, so ensure that the device has enough free
     memory to complete the update.
     
     @param Object
     */
    
    func updateCheck(for task: ToDoItem) {
        
        taskRef.child(task.key).updateChildValues([
            "completed": task.completed
        ])
    }
    
    // MARK: REMOVE
    
    /**
     Asynchronously removes all obsever signals at the FirebaseDatabase.
     */
    func removeAllObservers() {
        
        taskRef.removeAllObservers()
    }
    
    // MARK: DOWNLOAD
    
    /**
     Asynchronously downloads the object at the FIRStorageReference to an NSData Object in memory.
     An NSData of the provided max size will be allocated, so ensure that the device has enough free
     memory to complete the download. For downloading large files, writeToFile may be a better option.
     
     @param size The maximum size in bytes to download.  If the download exceeds this size the task will be cancelled and an error will be returned.
     @param block to create UIImage
     */
    
    let bucket: String = "gs://bellabeat-e59b7.appspot.com"
    
    
    func getImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let storageRef = storage.reference(forURL: bucket)
        let path = storageRef.child("\(urlString)")
        
        path.getData(maxSize: 1024 * 1024) { (data, error) in
            guard let data = data else { return }
            if (error != nil) {
                print(error!.localizedDescription)
            } else {
                let image = UIImage(data: data)
                completion(image)
                
            }
        }
    }
    
    
}
