//
//  MainView.swift
//  TodoList
//
//  Created by Jonathan Cheng on 8/27/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()

    var body: some View { //if User is signed in, goes to accountView and past Auth, if user is not signed in, sent back to LoginView
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            accountView
        } else {
            LoginView()
        }
    }

    @ViewBuilder
    var accountView: some View {
        TabView { //Tab on bottom of the app screen, to navigate to various screens in app
            Home(userId: viewModel.currentUserId)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            ToDoListView(userId: viewModel.currentUserId)
                .tabItem {
                    Label("Tasks", systemImage: "checklist")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
