//
//  TaskFormScreen.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 2/1/23.
//

import SwiftUI

enum Eta: String, CaseIterable {
    case now = "now"
    case asap = "ASAP(urgent!!!)"
    case byTommorow = "By Tommorow"
    case ByEndOfWeek = "By the end if the week"
    case whenYouGetChance = "When you get a chance"
    case custom = "Custom"
}

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
                        ForEach(Eta.allCases, id: \.self) { eta in
                            Text(eta.rawValue)
                        }
//                        Text("When you get a chance").tag(Eta.whenYouGetChance)
//                        Text("now").tag(Eta.now)
//                        Text("ASAP(urgent!!!)").tag(Eta.asap)
//                        Text("By Tommorow").tag(Eta.byTommorow)
//                        Text("By the end if the week").tag(Eta.ByEndOfWeek)
//                        Text("Custom").tag(Eta.custom)
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
                                                .overlay {Circle()
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
            ///Send Button
            Button {
                Task {
                    do {
                        let task = Todo(userId: sendTaskVM.currentUser.id,
                                        fullName: sendTaskVM.currentUser.fullName,
                                        senderProfilePicUrl: sendTaskVM.currentUser.image,
                                        todo: textEditor,
                                        eta: eta.rawValue,
                                        custom: customTextField,
                                        timestamp: Date())
                        
                        try await sendTaskVM.sendTask(todo: task, image: selectedImage)
                    } catch {
                        print("🤢 error sending task, taskFormScreen button: \(error)")
                        return
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
