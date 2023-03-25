//
//  TaskListScreen.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 2/1/23.
//

import SwiftUI

struct TaskListScreen: View {
    
    @EnvironmentObject var model: LoginViewModel
    
    var body: some View {
        
        /// use the tutorial from sean allen swiftUI form, it has all that i need to make the request form for teachers to fill out and send me with a task
        VStack {
            Text("add a task!")
                .padding()
            Button {
             
                AuthViewModel.logOut()
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
            }
        }
        

    }
}

struct TaskListScreen_Previews: PreviewProvider {
    static var previews: some View {
        TaskListScreen()
            .environmentObject(LoginViewModel())
    }
}
