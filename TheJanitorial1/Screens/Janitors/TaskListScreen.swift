//
//  TaskListScreen.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 2/1/23.
//

import SwiftUI

//TODO: JANITOR MESSAGES, TO ASK THE SENDERS QUESTIONS OR SO THEY CAN ASK ME STUFF
//TODO: Maybe arrange the todos based on urgency(eta enum), or the timestamp, or both

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
            List {
                
                ForEach(taskListVM.tasks) { task in
                                        
                    Button {
                        taskListVM.isPresented = true
                    } label: {
                        //                  TODO: refactor the task list row to a its on view
                        
                        HStack {
                          
                            ProfilePicView(user: sender)
                                .padding(.trailing)
                            
                            VStack(alignment: .leading) {
                                
                                Text(task.fullName!)
                                    .bold()
                                
                                HStack {
                                    
                                    Text(DateHelper.TaskTimestampDateFrom(date: task.timestamp))
                                        .font(.caption)
                                    
                                    Text(task.eta == C.custom ? task.custom! : task.eta!)
                                    
                                    Text(DateHelper.TaskTimestampHourFrom(date: task.timestamp))
                                    
                                }//Hstack
                                .font(.callout)
                                
                            }// Vstack
                        }//Hstack
                        .tint(.black)
                        .listRowBackground(Color.clear)
                        .sheet(isPresented: $taskListVM.isPresented) {
                            TaskRequest(task: task)
                        }
                    }
                }//ForEach
                .onDelete { IndexSet in
                    //figure this out
                }
            }//List
            .listStyle(.plain)
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
