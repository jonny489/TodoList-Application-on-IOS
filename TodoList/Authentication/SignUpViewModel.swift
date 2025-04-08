//
//  SignUpViewModel.swift
//  TodoList
//
//  Created by Jonathan Cheng on 8/21/23.
//

import FirebaseFirestore
import FirebaseAuth
import Foundation

// View model responsible for handling user registration logic and data.
class SignUpViewModel: ObservableObject {
    // Published properties to store the user's name, email, and password
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""

    // Initializes a new instance of the RegisterViewViewModel.
    init() {}

    // Registers a new user with the provided name, email, and password.
    func register() {
        guard validate() else {
            return
        }

        // Create a new user with Firebase Authentication
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let userId = result?.user.uid else {
                return
            }

            self?.insertUserRecord(id: userId)
        }
    }

    
    /// Inserts a new user record into Firebase database
    /// 
    /// - Parameter id: user's unique identifier
    private func insertUserRecord(id: String) {
        let newUser = User(id: id,
                           name: name,
                           email: email,
                           joined: Date().timeIntervalSince1970)

        let db = Firestore.firestore()

        // Insert the user record into the "users" collection
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }

    /// Validates the user's input for registration.
    ///
    /// - Returns: A boolean indicating whether the input is valid.
    private func validate() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }

        // Check if the email contains "@" and "."
        guard email.contains("@") && email.contains(".") else {
            return false
        }

        // Check if the password has a minimum length of 6 characters, if it does it is a viable password
        guard password.count >= 6 else {
            return false
        }

        return true
    }
}
