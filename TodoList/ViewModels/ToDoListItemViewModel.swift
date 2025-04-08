//
//  ToDoListItemViewModel.swift
//  TodoList
//
//  Created by Jonathan Cheng on 8/26/23.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

/// ViewModel for single to do list item view (each row in items list)
class ToDoListItemViewModel: ObservableObject {
    init() {}
    /// Toggles the completion status of a to-do list item and updates it in Firestore.
    /// - Parameter item: The to-do list item to toggle.
    func toggleIsDone(item: ToDoListItem) {
        //creates a mutable copy of the item
        var itemCopy = item
        //Set if complete or not
        itemCopy.setDone(!item.isDone)
        
        //checks if a user is signed in and gets their UID(user ID)
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }

        let db = Firestore.firestore()
        //updates the to-do item in Firestore
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())//updating item
    }
}
