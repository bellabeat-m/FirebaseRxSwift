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
    private let taskAPI = FireTaskAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsMultipleSelectionDuringEditing = false
        navigationController?.navigationBar.prefersLargeTitles = false
        updateTasks()
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        taskAPI.removeAllObservers()
        
    }
    func updateTasks() {
        taskAPI.observeData(completed: { [weak self] tasks, error in
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
        
        let controller = WorkoutViewController()
        self.navigationController?.pushViewController(controller, animated: true)
//        let alert = UIAlertController(title: "Things to do",
//                                      message: "Add a task",
//                                      preferredStyle: .alert)
//
//        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
//
//            guard let textField = alert.textFields?.first,
//
//                let cancelAction = UIAlertAction(title: "Cancel",
//                                                 style: .cancel)
//
//            alert.addTextField()
//            alert.addAction(saveAction)
//            alert.addAction(cancelAction)
//
//            present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: UITableView Delegate & DataSource methods
    
    extension ListTableViewController: UITableViewDataSource, UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tasksList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // cell as? TaskTableViewCell)?.configure(with: tasks.first)
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier) as! TaskTableViewCell
            let item = tasksList[indexPath.row]
            
            
            cell.lblTask.text = tasksList[indexPath.row].name
            cell.lblComplete.text = "Set task complete"
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
            
            taskAPI.removeTask(for: taskSelected) // remove from Firebase

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        var task = tasksList[indexPath.row]
//        let toggledCompletion = !task.completed
//        toggleCellCheckbox(cell, isCompleted: toggledCompletion)
//        task.completed = toggledCompletion
//        
//        taskAPI.updateCheck(for: task)
        tableView.deselectRow(at: indexPath, animated: true)
         let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        let controller: DetailViewController = storyboard.instantiateViewController(withIdentifier: "detail") as! DetailViewController
        controller.task = task
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func toggleCellCheckbox(_ cell: UITableViewCell, isCompleted: Bool) {
        cell.accessoryType = isCompleted ? .checkmark : .none
        cell.textLabel?.textColor = isCompleted ? .gray : .black
        cell.detailTextLabel?.textColor = isCompleted ? .gray : .black
    }
}
