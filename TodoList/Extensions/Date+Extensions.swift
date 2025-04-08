//
//  Date+Extensions.swift
//  TodoList
//
//  Created by Jonathan Cheng on 9/2/23.
//

import SwiftUI
import Foundation

extension Date{
    /// Formats the date into a string using the specified format.
    /// - Parameter format: A string specifying the desired date format.
    /// - Returns: A formatted string representation of the date.
    func format(_ format: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}

extension Encodable{
    /// Converts an encodable object into a dictionary.
    ///
    /// - Returns: A dictionary representation of the encodable object.
    func asDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else{
            return[:]
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        } catch{
            return[:]
        }
    }
}
