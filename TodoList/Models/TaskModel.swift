//
//  TaskModel.swift
//  TodoList
//
//  Created by Jonathan Cheng on 8/20/23.
//

import Foundation
import Combine
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift


class TaskModel: ObservableObject{
    @FirestoreQuery var items: [ToDoListItem] // Firestore query to retrieve to-do list items
    
    init(userId: String) {
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/todos"
        )
        fetchCurrentWeek()
        // call filterTasks and then pass the filtered tasks to a viewModel that'll take the data and display it
    }
    
    @Published var currentWeek: [Date] = [] // Published property to store the current week's dates
    
    @Published var currentDay: Date = Date() // Published property to store the current day

    

    //Filters tasks based on their date
    func filterTasks(inputArray:Array<ToDoListItem>) -> Array<ToDoListItem>  {
        var testArr: [ToDoListItem] = []

        for item in inputArray{
            //Filter today tasks
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date1 = dateFormatter.string(from: item.dueDateAsDate)
            let date2 = dateFormatter.string(from: currentDay)
            if dateComparator(date1: date1, date2: date2){
                testArr.append(item)
            }
        }
        return testArr
    }
    func dateComparator(date1: String, date2: String)-> Bool{
        // Compare two dates and return true if date1 is equal to date2
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date1f = dateFormatter.date(from: date1),
           let date2f = dateFormatter.date(from: date2) {
            
            let result = date1f.compare(date2f)
            
            if result == .orderedAscending {
                return false
            } else if result == .orderedDescending {
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }

    func fetchCurrentWeek(){ //Fetches dates for the current week
        
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else{
            return
        }
        
        (0...6).forEach{
            day in
            
            if let weekday = calendar.date(byAdding: .day, value: day, to :firstWeekDay){
                currentWeek.append(weekday)
            }
        }
    }
    
    //Extract Date
    
    func extractDate(date: Date, format: String) -> String{
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        
        return formatter.string(from: date)
    }
    
    
    // Check if a given date is today, returns true if it is today
    func isToday(date: Date) -> Bool {
        let calendar = Calendar.current
        let currentDateComponents = calendar.dateComponents([.year, .month, .day], from: currentDay)
        let targetDateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        return currentDateComponents == targetDateComponents
    }
}
