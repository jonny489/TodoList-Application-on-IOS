//
//  TodoListApp.swift
//  TodoListApp
//
//  Created by Jonathan Cheng on 8/16/23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth

@main
struct TodoList_appApp: App {
    // Initialize Firebase when the app is launched
    init() {
        FirebaseApp.configure() //Configure Firebase
    }
    var body: some Scene {
        WindowGroup {
            MainView() //The view that will be displayed when the app opens
        }
        }
    }

