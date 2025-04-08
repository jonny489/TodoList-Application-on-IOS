//
//  MainViewModel.swift
//  TodoList
//
//  Created by Jonathan Cheng on 8/27/23.
//

import FirebaseAuth
import Foundation

class MainViewModel: ObservableObject {
    @Published var currentUserId: String = "" // Published property to store the current user's ID
    private var handler: AuthStateDidChangeListenerHandle?

    init() {
        // Initialize the view model and set up an authentication state change listener to check if user is signed in
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                // Update the current user's ID when the authentication state changes
                self?.currentUserId = user?.uid ?? "" // If user is nil sets ID to an empty string
            }
        }
    }

    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
