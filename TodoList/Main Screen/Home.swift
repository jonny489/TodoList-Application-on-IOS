//
//  Home.swift
//  TodoList
//
//  Created by Jonathan Cheng on 8/27/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct Home: View {
    // Function to convert a date to a string with a given format
    func dateToString(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: date)
    }
    
    @FirestoreQuery var items: [ToDoListItem]
    @StateObject var viewModel: ToDoListViewModel
    @StateObject var taskModel: TaskModel
    
    // Initialize the view with a user ID
    init(userId: String) {
        self._viewModel = StateObject(
            wrappedValue: ToDoListViewModel(userId: userId) // Put userId into the viewModel
        )
        self._taskModel = StateObject(
            wrappedValue: TaskModel(userId: userId) // Put userId into the taskModel
        )
        
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/todos" //path to each user and their subcollection of todos
        )
    }
    
    @Namespace var animation
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                Section {
                    // Mark: Current Week view
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(taskModel.currentWeek, id: \.self) { day in
                                VStack(spacing: 10) {
                                    Text(taskModel.extractDate(date: day, format: "dd")) //Shows Day number as, ex: 12
                                        .font(.system(size: 14))
                                        .fontWeight(.semibold)
                                    Text(taskModel.extractDate(date: day, format: "EEE")) //Shows Days as, ex: Sun
                                        .font(.system(size: 14))
                                        .fontWeight(.semibold)
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 8, height: 8)
                                        .opacity(taskModel.isToday(date: day) ? 1 : 0)
                                }
                                // Foreground style
                                .foregroundStyle(taskModel.isToday(date: day) ? .primary : .tertiary)
                                .foregroundColor(taskModel.isToday(date: day) ? .white : .black)
                                .frame(width: 45, height: 80)
                                .background(
                                    ZStack {
                                        // Matched geometry animation when a weekday is changed
                                        if taskModel.isToday(date: day) {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(.black)
                                                .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                        }
                                    }
                                )
                                .contentShape(RoundedRectangle(cornerRadius: 10))
                                .onTapGesture {
                                    // Update current day
                                    withAnimation {
                                        taskModel.currentDay = day
                                    }
                                }
                            }
                        }.offset(y: 0) // May need to readjust
                    }
                    TasksView()
                }
                
                header: {
                    HeaderView()
                }
            }
            .background(Color(.white))
            .navigationTitle("Today's Tasks")
        }
    }
    
    // Tasks View
    func TasksView() -> some View {
        LazyVStack(spacing: 18) {
            let tasks = taskModel.filterTasks(inputArray: items) // Filter out all tasks in items array and put them into an array called tasks
            if tasks.isEmpty {
                Text("All Done!")
                    .font(.system(size: 16))
                    .fontWeight(.light)
                    .offset(y: 100)
            } else {
                ForEach(tasks) { task in
                    TaskCardView(task: task)
                }
            }
        }
    }
    
    // Task Card View
    func TaskCardView(task: ToDoListItem) -> some View {
        return HStack(alignment: .top, spacing: 30) {
            VStack(spacing: 10) {
                Circle()
                    .fill(.black)
                    .frame(width: 15, height: 15)
                    .background(
                        Circle()
                            .stroke(.black, lineWidth: 1)
                            .padding(-3)
                    )
                Rectangle()
                    .fill(.black)
                    .frame(width: 3)
            }
            VStack {
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(task.title)
                            .font(.title2.bold())
                        Text(dateToString(date: task.dueDateAsDate, format: "h:mm a")) //On Each Todo, puts the Hour, minutes, and AM or PM
                            .font(.callout)
                    }
                }
                .hLeading()
                .padding()
                .background((Color("Black"))
                    .cornerRadius(10)
                )
            }
            .hLeading()
        }
    }
    
    func HeaderView() -> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                Text("Hello!")
                    .font(.largeTitle).bold()
            }
            .hLeading()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(userId: "arTo0NAhaZYg2KKA6ndgu5a8j682") //example userID
    }
}

// UI Design helper functions
extension View {
    func hLeading() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
}
