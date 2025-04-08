//
//  ToDoListView.swift
//  TodoList
//
//  Created by Jonathan Cheng on 8/26/23.
//

import FirebaseFirestoreSwift
import SwiftUI

struct ToDoListView: View {
    @StateObject var viewModel: ToDoListViewModel
    @FirestoreQuery var items: [ToDoListItem] //retrieve ToDoListItems from firebase

    // Initialize the view with a user ID
    init(userId: String) {
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/todos"
        )
        self._viewModel = StateObject(
            wrappedValue: ToDoListViewModel(userId: userId) // Put userId into the viewModel
        )
    }

    var body: some View {
        NavigationView {
            VStack {
                List(items) { item in //Displays the to-dolist items from Firestore
                    ToDoListItemView(item: item)
                        .swipeActions { //swipe to delete
                            Button {
                                viewModel.delete(id: item.id)
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                        }
                        .listStyle(PlainListStyle())
                }
                .navigationTitle("Task")
                .toolbar {
                    Button {
                        viewModel.showingNewItemView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemView(newItemPresented: $viewModel.showingNewItemView)
            }
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(userId: "arTo0NAhaZYg2KKA6ndgu5a8j682") //example userID
    }
}
