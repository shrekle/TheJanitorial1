//
//  TaskListScreen.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 2/1/23.
//

import SwiftUI

//TODO: JANITOR MESSAGES, TO ASK THE SENDERS QUESTIONS OR SO THEY CAN ASK ME STUFF

/// use the tutorial from sean allen swiftUI form, it has all that i need to make the request form for teachers to fill out and send me with a task


struct TaskListScreen: View {
        
    @StateObject private var vm = TaskListVM()
    
    var body: some View {
     
        VStack {
            ///Heading
            HStack {
                Text("TO DOO-DOO'S")
                    .font(.largeTitle)
                
                Spacer()
                ///Gear
                //TODO: change profile info, change email or password
                Button {
                    AuthViewModel.logOut()
                } label: {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
            .padding(.top, 20)
            ///Task List
            if !vm.tasks.isEmpty {
                
            } else {
                Spacer()
                Text("Click on the plus icon on your bottom right to add a task 😀")
                    .font(.body)
                    .bold()
                    .foregroundColor(.gray)
                    .padding(.horizontal, 40)
                Spacer()
            }
            ///Plus Icon Button
            HStack {
                
                Spacer()
                
                Button {
                    vm.isPresented = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                }
            }
            .sheet(isPresented: $vm.isPresented) {
            
            }
        }

        .padding()
    }
}

struct TaskListScreen_Previews: PreviewProvider {
    static var previews: some View {
        TaskListScreen()
            .environmentObject(LoginViewModel())
    }
}
