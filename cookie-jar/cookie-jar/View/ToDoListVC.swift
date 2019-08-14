//
//  ToDoListVC.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-07.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import UIKit

class ToDoListVC: UIViewController {
    
    // MARK: Properties
    private let toDoListViewModel = ToDoListVM()
    private var pointsString: String = {
        return "Testing"
    }()
    
    private lazy var navBar: UINavigationBar = {
        let navBar = UINavigationBar()
        let navItem = UINavigationItem(title: "To-Do List")
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: #selector(addToDoItem))
        let profileItem = UIBarButtonItem(title: pointsString, style: .plain, target: nil, action: #selector(presentProfilePopup))
        navItem.rightBarButtonItem = addItem
        navItem.leftBarButtonItem = profileItem
        navBar.setItems([navItem], animated: false)
        return navBar
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ToDoItemCell")
        tableView.endEditing(true)
        return tableView
    }()
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        [navBar, tableView].forEach { view.addSubview($0) }
        tableView.delegate = self
        tableView.dataSource = self
        navBar.setEdgeConstraints(top: view.safeAreaLayoutGuide.topAnchor, bottom: tableView.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        tableView.setEdgeConstraints(top: navBar.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
    }
    
    // MARK: Actions
    @objc func addToDoItem() {
        let popup = AddToDoItemView()
        popup.toDoCreationDelegate = self
        self.view.addSubview(popup)
    }
    
    @objc func presentProfilePopup() {
        tableView.reloadData()
    }
}

// MARK: - Delegate Methods
extension ToDoListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return toDoListViewModel.getToDoList().count
        } else {
            return toDoListViewModel.getCompletedToDoList().count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var toDoItem: ToDoItem
        if indexPath.section == 0 {
            toDoItem = toDoListViewModel.getToDoList()[indexPath.row]
        } else {
            toDoItem = toDoListViewModel.getCompletedToDoList()[indexPath.row]
        }
        var cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell = UITableViewCell(style: .value1, reuseIdentifier: "ToDoItemCell")
        cell.textLabel?.text = toDoItem.title
        cell.detailTextLabel?.text = toDoListViewModel.getPointsString(numPoints: toDoItem.points)
        cell.accessoryType = toDoListViewModel.getAccessoryType(completed: toDoItem.completed)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Active"
        } else {
            return "Completed"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            toDoListViewModel.toggleToDoItem(index: indexPath.row, completed: false)
        } else {
            toDoListViewModel.toggleToDoItem(index: indexPath.row, completed: true)
        }
    }
}

extension ToDoListVC: ToDoCreationDelegate {
    func createNewToDoItem(title: String, points: Int) {
        toDoListViewModel.createToDoItem(title: title, points: points)
    }
}