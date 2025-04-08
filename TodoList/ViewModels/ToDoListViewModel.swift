//
//  ToDoListViewModel.swift
//  TodoList
//
//  Created by Jonathan Cheng on 8/26/23.
//

import Foundation
import FirebaseFirestore

class ToDoListViewModel: ObservableObject {
    @Published var showingNewItemView = false // Published property to control the display of the new item view
    
    private let userId: String
    init(userId: String){
        self.userId = userId
    }
    
    /// Deletes a to-do list item with the specified ID from Firestore.
    /// - Parameter id: The ID of the item to delete.
    func delete(id: String){
        let db = Firestore.firestore()
        // Deletes the specified to-do list item document from Firestore
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }

}
