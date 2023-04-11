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

//TODO: QUICK REQUESTS: Put premade request of the most reoccuring things, Let users make a favorite requests list thing

struct TaskFormScreen: View {
    
    @EnvironmentObject var sendTaskVM: SendTaskViewModel
    
    @Binding var taskStatus: TaskSendingStatus
    
    @State var textEditor = ""
    @State var eta = Eta.whenYouGetChance
    @State var customTextField = ""
    @State var selectedImage: UIImage?
    @State var isPickerShowing = false
    @State var isSourceMenuShowing = false
    @State var source: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    Text("To-doodoo:")
                        .font(.title3)
                    
                    ZStack {
                        ///TextField
//                    TODO: Dissmiss keyboard button
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
                        .padding(.top, 30)
                    ///Picker
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
                            .padding(.top)
                    }
                    
                    Text("A picture is worth a 1000 words 😀:")
                        .font(.title3)
                        .padding(.top,30)
                    
                    HStack {
                        
                        Spacer()
                        
                        Button {
                            isSourceMenuShowing = true
                        } label: {
                            VStack {
                                ///Image
                                //            TODO: extract this into a view
                                ZStack {    //  camara circle
                                    if let selectedImage {
                                        Image(uiImage: selectedImage)
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .shadow(radius: 5)
                                    } else {
                                        ZStack {
                                            
                                            Circle()
                                                .foregroundColor(.white)
                                                .shadow(radius: 5)
                                                .overlay {
                                                    Circle()
                                                        .stroke(lineWidth: 2)
                                                        .foregroundColor(.blue)
                                                }
                                            
                                            Image(systemName: "toilet.fill")
                                                .resizable()
                                                .scaleEffect(0.5)
                                                .scaledToFit()
                                                .tint(Color(.gray))
                                                .padding()
                                        }
                                        .frame(height: 134)
                                    }
                                }   //  Zstack camara circle
                            }
                        }
                        Spacer()
                    }//toilet hstack
                }//Vstack
            }//Scrolly
            ///Button
            Button {
               
                Task {
                    do {
                        let currrentUser = try await DatabaseService.gitCurrentUserModel()
                        
                        let task = Todo(fullName: currrentUser.fullName, todo: textEditor, eta: , custom: customTextField, imageUrl: <#T##String?#>)
                        
                        sendTaskVM.sendTask(todo: <#T##Todo#>, user: <#T##String#>)
                    } catch {
                        
                    }
                }
                taskStatus = .isSent
            } label: {
                Text("Send Task")
            }
            .buttonStyle(OnboardingButtonStyle())
        }//main
        .padding(.horizontal)
        ///SHEET
        .sheet(isPresented: $isPickerShowing) {
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing, source: source )
        }
        ///CONFIRMATION DIALOG
        .confirmationDialog("From where?", isPresented: $isSourceMenuShowing) {
            
            Button {
                self.source = .photoLibrary
                isPickerShowing = true
            } label: {
                Text("From Photo Library")
            }
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                Button {
                    self.source = .camera
                    isPickerShowing = true
                } label: {
                    Text("flic' a Pic")
                }
            }
        }
    }
}

struct AddTaskScreen_Previews: PreviewProvider {
    static var previews: some View {
        TaskFormScreen(taskStatus: .constant(.fillOut))
    }
}
