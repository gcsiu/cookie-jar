//
//  ToDoListVM.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-09.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import Foundation

class ToDoListVM {
    
    // MARK: Properties
    private var toDoList = [ToDoItem]()
    private var completedToDoList = [ToDoItem]()
    private let defaults = UserDefaults.standard
    
    // MARK: Methods
    func createToDoItem(title: String, points: Int) {
        let newToDoItem = ToDoItem(title: title, points: points)
        toDoList.append(newToDoItem)
    }
    
    func deleteToDoItem(index: Int, completed: Bool) {
        if completed {
            completedToDoList.remove(at: index)
        } else {
            toDoList.remove(at: index)
        }
    }
    
    func getToDoList() -> [ToDoItem] {
        return toDoList
    }
    
    func getCompletedToDoList() -> [ToDoItem] {
        return completedToDoList
    }
    
    func getPointsString(numPoints: Int) -> String {
        if numPoints == 1 {
            return "\(numPoints) point"
        } else {
            return "\(numPoints) points"
        }
    }
}
