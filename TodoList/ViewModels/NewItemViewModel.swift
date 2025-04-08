//
//  NewItemViewModel.swift
//  TodoList
//
//  Created by Jonathan Cheng on 8/26/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class NewItemViewModel: ObservableObject{
    // Published properties to track the title, due date, and alert status
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    init(){}
    
    /// Saves a new to-do list item to Firestore if it meets the criteria.
    func save(){
        guard canSave else{
            return
        }
        
        //get current user id
        guard let uId = Auth.auth().currentUser?.uid else{
            return
        }
        //create a new unique ID for the to-do item
        let newId = UUID().uuidString
        
        //creates a new ToDoListItem model
        let newItem = ToDoListItem(id: newId, title: title, dueDate: dueDate.timeIntervalSince1970, createdDate: Date().timeIntervalSince1970, isDone: false)
        
        //Accesses Firestore and saves the new model to database
        let db = Firestore.firestore()
        db.collection("users")
            .document(uId)
            .collection("todos")
            .document(newId)
            .setData(newItem.asDictionary())
    }
    
    ///Checks if a new todo item can be saved
    var canSave: Bool{
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else{
            return false
        }
        //86400 seconds in the day, ensures that the due date is ate least one day in the future
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        return true
    }
}
