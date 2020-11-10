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
    private var tasksList = [ToDoItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelectionDuringEditing = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .red
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = .red
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        updateTasks()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        FireAPI.shared.removeAllObservers()
        
    }
    func updateTasks() {
        FireAPI.shared.getData(update: { [weak self] tasks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self?.tasksList = tasks
            self?.tableView.reloadData()
        })
    }
    
// MARK: Add Task
    
    @IBAction func addButtonDidTouch(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Things to do",
                                      message: "Add a task",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            
            guard let textField = alert.textFields?.first,
                let text = textField.text else { return }
            FireAPI.shared.insertTask(with: text)
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

extension ListTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksList.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        let item = tasksList[indexPath.row]
        
        cell.textLabel?.text = tasksList[indexPath.row].name
        toggleCellCheckbox(cell, isCompleted: item.completed)
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskSelected = tasksList[indexPath.row].key
            self.tasksList.remove(at: indexPath.row) // remove from datasource
            tableView.deleteRows(at: [indexPath], with: .fade) // delete the row
            
            FireAPI.shared.removeTask(for: taskSelected) // remove from Firebase

        }
    }
    
// Samo jednom selektiranje taskova
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        var task = tasksList[indexPath.row]
        let toggledCompletion = !task.completed
        toggleCellCheckbox(cell, isCompleted: toggledCompletion)
        task.completed = toggledCompletion
        
        FireAPI.shared.updateCheck(for: task)
    }
    
    func toggleCellCheckbox(_ cell: UITableViewCell, isCompleted: Bool) {
        cell.accessoryType = isCompleted ? .checkmark : .none
        cell.textLabel?.textColor = isCompleted ? .gray : .black
        cell.detailTextLabel?.textColor = isCompleted ? .gray : .black
    }
}


extension ListTableViewController {

    func addFirebaseObservers() {
        FireAPI.shared.listenForAllChildEvents(with: "", update: { snapshot, error, type in
            switch type {
                case .some(.childAdded): break
                case .some(.childRemoved): break
                case .some(.childChanged): break
                default: break

            }
        })
    }
    
    func addObservers() {
        
    }
    
    

}
