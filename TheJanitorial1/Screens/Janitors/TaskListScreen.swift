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
    
    @StateObject var taskListVM = TaskListViewModel()
    
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
            }//Hstack Heading
            .padding()
            
            ///Task List
            
            if !taskListVM.tasks.isEmpty {
                
                List {
                    
                    ForEach(taskListVM.tasks) { task in
                       
                        
                        Button {
                            taskListVM.isPresented = true
                        } label: {
                            //                  TODO: refactor the task list row to a its on view
                            
                            HStack {
                                
                                ProfilePicView(currentUser: taskListVM.searchForUser(senderID: task.userId!))
                                                .padding(.trailing, 5)
                                
                                VStack(alignment: .center) {
                                 
                                        Text(task.fullName ?? "name is nil")
                                            .bold()
                                            .padding(.leading, 10)
                                        
                                    HStack(spacing: 5) {
                                      
                                        Text(task.eta == C.custom ? task.custom! : task.eta!)
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                        
                                    }//Hstack
                                    .font(.callout)
                                    
                                }// Vstack
                                VStack(alignment: .trailing) {
//                                    Spacer()
                                    
                                    Text(DateHelper.TaskTimestampDateFrom(date: task.timestamp))
                                        .font(.caption)
                                    
                                    Text(DateHelper.TaskTimestampHourFrom(date: task.timestamp))
                                }
                                
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
//                .listStyle(.pla)
            } else {
                
                Spacer()
                VStack {
                    HStack(spacing: 0) {
                        Text("NO TO ")
                             .font(.title)
                        
                        Text("DOO-DOO'S!!!")
                            .font(.title)
                            .foregroundColor(.brown)
                            .bold()
                    }//Hstack
                    
                    Text("💩")
                        .scaleEffect(3.5)
                        .padding(.top)
                }
               
                Spacer()
            }
           
        }//MainVstack
        .padding(.vertical)
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
