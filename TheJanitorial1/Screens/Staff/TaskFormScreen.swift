//
//  TaskFormScreen.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 2/1/23.
//

import SwiftUI

enum Eta {
    case now
    case asap
    case byTommorow
    case ByEndOfWeek
    case whenYouGetChance
    case custom
}
/// use the tutorial from sean allen swiftUI form, it has all that i need to make the request form for teachers to fill out and send me with a task

struct TaskFormScreen: View {
    
    @Binding var taskStatus: TaskSendingStatus
    
    @State var textEditor = ""
    @State var eta = Eta.whenYouGetChance
    @State var customTextField = ""
    
    var body: some View {
        
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    Text("To-doodoo:")
                        .font(.title3)
                    
                    ZStack {
                        //                        TODO: Dissmiss keyboard button
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                        
                        TextEditor(text: $textEditor)
                            .padding(4)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.blue))
                    }
                    .frame(height: 70)
                    .padding(.horizontal)
                    
                    Text("Time needed by:")
                        .font(.title3)
                    
                    Picker("", selection: $eta) {
                        Text("When you get a chance").tag(Eta.whenYouGetChance)
                        Text("now").tag(Eta.now)
                        Text("ASAP(urgent!!!)").tag(Eta.asap)
                        Text("By Tommorow").tag(Eta.byTommorow)
                        Text("By the end if the week").tag(Eta.ByEndOfWeek)
                        Text("Custom").tag(Eta.custom)
                    }
                    .pickerStyle(.wheel)
                    .background(RoundedRectangle(cornerRadius: 50).fill(.white))
                    .frame(height: 150)
                    .shadow(color: .black.opacity(0.1), radius: 5)
                    .padding(.horizontal)
                    
                    if eta == .custom {
                        TextField("Enter directions here", text: $customTextField)
                            .textFieldStyle(CreateProfileTextfieldStyle(buttonText: $customTextField))
                            .padding()
                    }
                        
                }//Vstack textEditor
                
                
            }//Scrolly
            ///Button
            Button {
                taskStatus = .isSent
            } label: {
                Text("Send Task")
            }
            .buttonStyle(OnboardingButtonStyle())
        }//main
        .padding(.horizontal)
    }
}

struct AddTaskScreen_Previews: PreviewProvider {
    static var previews: some View {
        TaskFormScreen(taskStatus: .constant(.fillOut))
    }
}
