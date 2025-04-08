//
//  LoginViewModel.swift
//  TodoList
//
//  Created by Jonathan Cheng on 8/18/23.
//  Loginviewmodel, stores Published variables and functions to login

import FirebaseAuth
import Foundation

class LoginViewModel: ObservableObject {
    //Published properties to store user email address, password, and error messages to display errors to user
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    
    init() {}// Initializes a new instance of the LoginViewViewModel.

    func login() { // Attempt to log in with the provided email and password.
        guard validate() else {
            return
        }

        // Try log in with Firebase Auth
        Auth.auth().signIn(withEmail: email, password: password)
    }
    //Validates the user's input for login, returns a boolean to indicate whether the input is valid
    private func validate() -> Bool {
        errorMessage = ""
        
        // Check if both email and password are not empty
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }
        
        // Check if the email contains "@" and "."/checks if it is an email
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter valid email."
            return false
        }

        return true
    }
}
