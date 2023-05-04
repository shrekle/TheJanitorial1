//
//  EditProfileForm.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 4/3/23.
//

import SwiftUI

//enum JobDescription {
//    case janitor
//    case OtherStaff
//}
//enum School: Int {
//    case elementarySchool = 3
//    case middleSchool = 2
//    case highSchool = 1
//}

struct EditProfileForm: View {
    
    @ObservedObject var settingsVM: SettingsViewModel
    
    @Binding var isEditProfileFormShowing: Bool
    
    @State private var fullName = ""
    
    //my Pickers
    @State var jobDescription = JobDescription.OtherStaff
    @State var school = School.middleSchool
    
    //Image PIcker
    @State var selectedImage: UIImage?
    @State var isPickerShowing = false
    @State var isSourceMenuShowing = false
    @State var source: UIImagePickerController.SourceType = .photoLibrary
    @State private var isSaveButtonDisabaled = false
    
    // for User's Profile
    var isJanitor: Bool {
        switch jobDescription {
        case .OtherStaff:
            return false
        case .janitor:
            return true
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Edit your profile")
                .font(.largeTitle)
                .padding(.top, 20)
            
            /// Profile Image Button
            HStack {
                Text("Change your profile image:")
                Spacer()
            }
            .padding(.top, 5)
            Button {
                isSourceMenuShowing = true
            } label: {
                //            TODO: extract this into a view
                ZStack {    //  camara circle
                    if let selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    } else {
                        Circle()//  need to use a circle before the stroke outline to be able to color the backgorund of it white...the backgorund of the screen will be gray
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                            .overlay {
                                Circle().stroke(lineWidth: 2)
                                    .foregroundColor(.blue)
                            }
                        Image(systemName: "camera.fill")
                            .tint(Color(.gray))
                    }
                }   //  Zstack camara circle
                .frame(width: 134, height: 134)
                
            } // Label Profile Button
            
            /// Textfields
            TextField("Update your Full Name", text: $fullName)
                .font(.callout)
                .textFieldStyle(CreateProfileTextfieldStyle(buttonText: $fullName))
            
            Button {
                
            } label: {
                Text("Update Password")
                    .underline()
            }
                        ///Pickers
            VStack {
                
                HStack {
                    Text("Update your Job Description:")
                    Spacer()
                }
                
                Picker("", selection: $jobDescription) {
                    Text("🥸 Other Staff").tag(JobDescription.OtherStaff)
                    Text("💩 Janitor").tag(JobDescription.janitor)
                }
                .pickerStyle(.menu)
                
                HStack {
                    Text("Update your School:")
                    Spacer()
                }
                
                Picker("", selection: $school) {
                    Text("Elementary School").tag(School.elementarySchool)
                    Text("Middle School").tag(School.middleSchool)
                    Text("High School").tag(School.highSchool)
                }
                .pickerStyle(.wheel)
                .background(RoundedRectangle(cornerRadius: 20).fill(.white))
                .frame(height: 100)
                .shadow(color: .black.opacity(0.1), radius: 5)
                .padding(.horizontal)

            } //    VStack Pickers
            .tint(.gray)
                            
            /// SAVE BUTTON
            Button {
                isSaveButtonDisabaled = true
                
                var name: String? {
                    if fullName == "" {
                        return nil
                    } else {
                        return fullName
                    }
                }
                
                Task {
                    do {
                        try await settingsVM.updateUserProfile(fullName: name, profileImage: selectedImage, isJanitor: isJanitor, schoolCode: school.rawValue)
                        isEditProfileFormShowing = false
                    } catch {
                        print("🥵 error in the button to register user: \(error)")
                    }
                }//Task
                
            } label: {
                Text(isSaveButtonDisabaled ? "Loading... ": "Update Profile")
            }
            .buttonStyle(OnboardingButtonStyle())
            .disabled(isSaveButtonDisabaled)
            .padding(.bottom)
            //MARK: - SHEET
            .sheet(isPresented: $isPickerShowing) {
                ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing, source: source )
            }
            
            //MARK: - CONFIRMATION DIALOG
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
        }// vstack Main
        .padding(.horizontal, 20)
        .onAppear {
            fullName = settingsVM.currentUser.fullName ?? ""
        }
    }
}

struct EditProfileForm_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileForm(settingsVM: SettingsViewModel(), isEditProfileFormShowing: .constant(false))
    }
}
