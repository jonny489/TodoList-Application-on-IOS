//
//  SignUpView.swift
//  TodoList
//
//  Created by Jonathan Cheng on 8/21/23.
//Sign-Up Screen

import SwiftUI
import Combine
import FirebaseAnalyticsSwift
import FirebaseAuth

// Enum to represent focusable fields for keyboard navigation
private enum FocusableField: Hashable {
    case name
    case email
    case password
}

struct SignUpView: View {
    @StateObject var viewModel = SignUpViewModel()  // Initialize the ViewModel for the view
    @FocusState private var focus: FocusableField?         // Track the currently focused field
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 100)
            
            Text("Sign Up")
                .font(.largeTitle)
                .bold()
            
            HStack {
                // Name Textbox
                Image(systemName: "person")
                TextField("Name", text: $viewModel.name)  // User inputs their name here
                    .textFieldStyle(DefaultTextFieldStyle())  // Use the default text field style
                    .disableAutocorrection(true)  // Disable autocorrection
                    .focused($focus, equals: .name)  // Bind focus state to the name field
                    .submitLabel(.next)  // Set keyboard "Next" action
                    .onSubmit {
                        self.focus = .email  // Move focus to email field on submit
                    }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black)
            )
            .padding()
            
            HStack {
                // Email Textbox
                Image(systemName: "mail")
                TextField("Email", text: $viewModel.email)  // User inputs email here
                    .textInputAutocapitalization(.never)  // Disable autocapitalization
                    .disableAutocorrection(true)  // Disable autocorrection
                    .focused($focus, equals: .email)  // Bind focus state to the email field
                    .submitLabel(.next)  // Set keyboard "Next" action
                    .onSubmit {
                        self.focus = .password  // Move focus to password field on submit
                    }
                Spacer()
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black)
            )
            .padding()
            
            HStack {
                // Password Textbox
                Image(systemName: "lock")
                SecureField("Password", text: $viewModel.password)  // User inputs password here
                    .textInputAutocapitalization(.never)  // Disable autocapitalization
                    .disableAutocorrection(true)  // Disable autocorrection
                    .focused($focus, equals: .password)  // Bind focus state to the password field
                Spacer()
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black)
            )
            .padding()
            
            NavigationLink {
                LoginView()  // Navigate to the login view
            } label: {
                Text("Have an account?")
                    .foregroundColor(.black)
            }
            
            TLButton(
                title: "Sign Up",
                background: .black
            ) {
                viewModel.register()  // Perform the registration action for an account
            }
            .frame(height: 50)
            .padding()
            
            Spacer()
                .padding()
            
            .navigationTitle("Sign Up")  // Set the navigation title
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}


