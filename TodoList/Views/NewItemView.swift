//
//  NewItemView.swift
//  TodoList
//
//  Created by Jonathan Cheng on 8/26/23.
//  Screen to make a new Todo

import SwiftUI

struct NewItemView: View {
    // The ViewModel responsible for managing new item creation
    @StateObject var viewModel = NewItemViewModel()
    
    // A binding to control the presentation of this view
    @Binding var newItemPresented: Bool
    
    var body: some View {
        VStack {
            Text("New Item")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 100)
            
            Form {
                // Text field for entering the title of the new item
                TextField("Title", text: $viewModel.title)
                
                // DatePicker for selecting the due date of the new item
                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                // Button to save the new item
                TLButton(title: "Save", background: .black) {
                    if viewModel.canSave {
                        // Save the new item if input is valid
                        viewModel.save()
                        
                        // Dismiss this view
                        newItemPresented = false
                    } else {
                        // Show an error alert if input is invalid
                        viewModel.showAlert = true
                    }
                }
                .padding()
            }
            // Alert to display an error message if input is invalid
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("Please fill in all fields and select a date either today or after today.")
                )
            }
        }
    }
}

struct NewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemView(newItemPresented: Binding(get: {
            return true
        }, set: { _ in
            // Handle setting the binding value if needed
        }))
    }
}
