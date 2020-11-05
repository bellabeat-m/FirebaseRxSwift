//
//  ViewController.swift
//  BellaBeatFirebase
//
//  Created by Marina Huber on 11/2/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ListTableViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var tasks: [ToDoItem] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelectionDuringEditing = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FireAPI.shared.getData(completed: { [weak self] tasks in
            self?.tasks = tasks
            self?.tableView.reloadData()
            
        })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        FireAPI.shared.taskPathAppending.removeAllObservers()
        
    }
    
// MARK: Add Task: TODO extract
    
    @IBAction func addButtonDidTouch(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Things to do",
                                      message: "Add a task",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            
            guard let textField = alert.textFields?.first,
                let text = textField.text else { return }
            
            let item = ToDoItem(name: text,
                                completed: false)
            let itemRef = FireAPI.shared.taskPathAppending.child(text.lowercased())
            
            itemRef.setValue(item.toAnyObject())
            self.tasks.append(item)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: UITableView Delegate & DataSource methods

extension ListTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        let item = tasks[indexPath.row]
        
        cell.textLabel?.text = item.name
        
        toggleCellCheckbox(cell, isCompleted: item.completed)
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let task = tasks[indexPath.row]
            task.ref?.removeValue()
            
            tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        var item = tasks[indexPath.row]
        let toggledCompletion = !item.completed
        
        toggleCellCheckbox(cell, isCompleted: toggledCompletion)
        item.completed = toggledCompletion
        
        
        item.ref?.updateChildValues([
            "completed": toggledCompletion
        ])

        tableView.reloadData()
    }
    
    
    func toggleCellCheckbox(_ cell: UITableViewCell, isCompleted: Bool) {
        if !isCompleted {
            cell.accessoryType = .none
            cell.textLabel?.textColor = .black
        } else {
            cell.accessoryType = .checkmark
            cell.textLabel?.textColor = .gray
        }
    }
}
