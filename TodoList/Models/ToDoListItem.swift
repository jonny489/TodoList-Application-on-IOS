//
//  ToDoListItem.swift
//  TodoList
//
//  Created by Jonathan Cheng on 8/19/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

/// Represents a ToDoListItem
struct ToDoListItem: Codable, Identifiable{
    let id: String //Unique identifier for the to-do item
    let title: String //Title of the todo item
    let dueDate: TimeInterval //Due date of the todo item in seconds since 1970
    let createdDate: TimeInterval //Creation date of the todo item in seconds since 1970
    var isDone: Bool //Indicates whether the todo item is completed or not
    
    // Converts the dueDate TimeInterval to a Date object
    var dueDateAsDate: Date{
        print(Date(timeIntervalSince1970: dueDate))
        return Date(timeIntervalSince1970: dueDate)
    }
    
    /// Sets the completion status of the to-do item.
    /// - Parameter state: The new completion status to be assigned.
    mutating func setDone(_ state: Bool){
        isDone = state 
    }
}

