//
//  TaskListScreen.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 2/1/23.
//

import SwiftUI

//TODO: JANITOR MESSAGES, TO ASK THE SENDERS QUESTIONS OR SO THEY CAN ASK ME STUFF

/// use the tutorial from sean allen swiftUI form, it has all that i need to make the request form for teachers to fill out and send me with a task

//
struct TaskListScreen: View {
        
    @StateObject private var taskListVM = TaskListViewModel()
    
    var body: some View {
     
        VStack {
            ///Heading
            HStack {
                
                Text("TO DOO-DOO'S")
                    .font(.largeTitle)
                    .bold()
                
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
            List(taskListVM.tasks) { thang in
//            TODO: need a time stamp to order the list and see when the task was created to judge when i have to do it
                Text(thang.todo!)
            }
            .sheet(isPresented: $taskListVM.isPresented) {
            
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
