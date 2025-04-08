//
//  TLButton.swift
//  TodoList
//
//  Created by Jonathan Cheng on 8/26/23.
//

import SwiftUI

struct TLButton: View {
    //Button with custom UI design
    let title: String
    let background: Color
    let action: () -> Void
    
    var body: some View {
        Button{
            action()
        }
    label:{
        ZStack{
            //Creates a rounded rectangle with corner radius of 10
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(background)
            
            //Button title
            Text(title)
                .foregroundColor(Color.white)
                .bold()
        }
    }
    }
}

struct TLButton_Previews: PreviewProvider {
    static var previews: some View {
        TLButton(title: "Value", background: .pink){
            // Action to perform when the button is tapped
        }
    }
}
