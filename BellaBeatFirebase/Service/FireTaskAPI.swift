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
    
    private var images: [String] = ["IMG_0.png", "IMG_1.png","IMG_2.png","IMG_3.png","IMG_4.png","IMG_5.png","IMG_6.png", "IMG_8.png", "IMG_9.png", "IMG_7.png"]
    init() { }
    
    // MARK: OBSERVE
    
    
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
    
    func insertTask(with name: String) {
        
        guard let key = taskID else { return }
        
        let item = ToDoItem(name: name, completed: false, key: key, imageURL: "")
        let taskChild = taskRef.child(key)
        taskChild.setValue(item.toAnyObject())
        
    }
    
    // MARK: DELETE
    
    func removeTask(for taskKeyID: String) {
        
        taskRef.child(taskKeyID).removeValue()
    }
    
    // MARK: UPDATE
    
    func updateCheck(for task: ToDoItem) {
        
        taskRef.child(task.key).updateChildValues([
            "completed": task.completed
        ])
    }
    
    // MARK: REMOVE
    
    func removeAllObservers() {
        
        taskRef.removeAllObservers()
    }
    
    // MARK: DOWNLOAD
    
    let bucket: String = "gs://bellabeat-e59b7.appspot.com"
    
    
    fileprivate func getRandomImage(_ completion: (UIImage?) -> Void) {
        let image = UIImage(named: images.randomElement() ?? "")
        completion(image)
    }
    
    func getImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        if urlString.isEmpty == true {
            getRandomImage(completion)
            return
        }
        let storageRef = storage.reference(forURL: bucket)
        let path = storageRef.child("\(urlString)")
        
        path.getData(maxSize: 1024 * 1024) { [weak self] (data, error) in
            guard let data = data else { return }
            if (error != nil) {
                self?.getRandomImage(completion)
                print("Error getting data. Returning local stored image: \(String(describing: error?.localizedDescription))")
            } else {
                let image = UIImage(data: data)
                completion(image)
            }
        }
    }
}
