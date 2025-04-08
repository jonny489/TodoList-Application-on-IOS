//
//  LoginView.swift
//  TodoList
//
//  Created by Jonathan Cheng on 8/18/23.
// Log-In Screen View

import SwiftUI
import Combine
import FirebaseAnalyticsSwift
import FirebaseAuth

// Enum to represent focusable fields for keyboard navigation
private enum FocusableField: Hashable {
    case email   // Allows the user to jump from email to password by pressing "Next" on user keyboard
    case password
}

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()  // Initialize the ViewModel for the view/connects to LoginViewViewModel to use the published variables to store user info and login to firebase
    @FocusState private var focus: FocusableField?   // Track the currently focused field

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                    .frame(height: 100)
                Text("Sign In")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                    .frame(height: 50)
                HStack {
                    // Email Text-box
                    Image(systemName: "mail")
                    TextField("Email", text: $viewModel.email) // User inputs Email here
                        .textInputAutocapitalization(.never)   // Disable autocapitalization
                        .disableAutocorrection(true)           // Disable autocorrection
                        .focused($focus, equals: .email)        // Bind focus state to email field
                        .submitLabel(.next)                     // Set keyboard "Next" action
                        .onSubmit {
                            self.focus = .password              // Move to password field on next click
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
                    // Password Text-box
                    Image(systemName: "lock")
                    SecureField("Password", text: $viewModel.password) // User inputs Password here
                        .textInputAutocapitalization(.never)   // Disable autocapitalization
                        .disableAutocorrection(true)           // Disable autocorrection
                        .focused($focus, equals: .password)     // Bind focus state to password field
                        .submitLabel(.done)                    // Set keyboard "Done" action
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
                    SignUpView()  // Navigate to the sign-up view
                } label: {
                    Text("Don't have an account?")
                        .foregroundColor(.black)
                }

                Spacer()

                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(Color.red)
                }

                Spacer()
                    .frame(height: 100)

                TLButton(
                    title: "Log In",
                    background: .black
                ) {
                    viewModel.login()  // Perform the login action
                }
                .frame(height: 50)
                .padding()
                .padding()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

