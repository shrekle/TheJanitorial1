//
//  TaskListScreen.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 2/1/23.
//

import SwiftUI


//TODO: deal when the task list is empty so it dont run out of the index
//TODO: JANITOR MESSAGES, TO ASK THE SENDERS QUESTIONS OR SO THEY CAN ASK ME STUFF
//TODO: Maybe arrange the todos based on urgency(eta enum), or the timestamp, or both

/// use the tutorial from sean allen swiftUI form, it has all that i need to make the request form for teachers to fill out and send me with a task

//@MainActor//remove
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
                            
                            ProfilePicView(currentUser: taskListVM.searchForUser(senderID: task.userId!))
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
                .onDelete(perform: removeTask)
            }//List
            .listStyle(.plain)
        }
        .padding()
    }
    
    //move this to the viewModel, if it works, or at least
    func removeTask(at offSets: IndexSet) {
        
        let task = taskListVM.tasks[offSets.first!]
        
        taskListVM.deleteTask(todoID: task.id!)
// since theres a listener maybe i dont need to explicitly remove from the tasks array since it will refresh by itself............theoretically
        taskListVM.tasks.remove(atOffsets: offSets)
        
    }
}

struct TaskListScreen_Previews: PreviewProvider {
    static var previews: some View {
        TaskListScreen()
            .environmentObject(LoginViewModel())
    }
}
