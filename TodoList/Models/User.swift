//
//  User.swift
//  TodoList
//
//  Created by Jonathan Cheng on 8/20/23.
//

import Foundation

/// Represents a user's information
struct User: Codable {
    let id: String // The unique identifier for the user.
    
    //A user's name, email, and a Timestamp of when they created an account
    let name: String
    let email: String
    let joined: TimeInterval
}
