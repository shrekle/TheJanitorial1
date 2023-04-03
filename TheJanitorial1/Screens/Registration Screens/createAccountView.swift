//
//  createAccountView.swift
//  chatAppCWC
//
//  Created by adrian garcia on 3/15/23.
//

import SwiftUI
import Combine

enum JobDescription {
    case janitor
    case OtherStaff
}
enum School: Int {
    case elementarySchool = 3
    case middleSchool = 2
    case highSchool = 1
}

struct createAccountView: View {
    
    @Binding var currentStep: registrationStep
    
    // my Textfields
    @State var email = ""
    @State var password = ""
    @State var fullName = ""
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
    
//    TODO: Check that all fields have been filled before allowing to proceed
//    TODO: Refactor the camara stuff, maybe have a standard ImagePicker view to choose a pic
//    TODO: CreateButtonStyle is not working to clear the text, make it a View and not a Style
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                Text("Create Your Account")
                    .font(.largeTitle)
                    .padding(.top, 20)
                
                /// Profile Image Button
                HStack {
                    Text("Choose your profile image:")
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
                TextField("Enter your Full Name", text: $fullName)
                    .font(.callout)
                    .textFieldStyle(CreateProfileTextfieldStyle(buttonText: $fullName))
                
                TextField("Enter your Email", text: $email)
                    .font(.callout)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(CreateProfileTextfieldStyle(buttonText: $email))
                
                SecureField("Choose your Password", text: $password)
                    .font(.callout)
                    .textFieldStyle(CreateProfileTextfieldStyle(buttonText: $password))
                
                ///Pickers
                VStack {
                    HStack {
                        Text("Choose your Job Description:")
                        Spacer()
                    }
                    
                    Picker("", selection: $jobDescription) {
                        Text("🥸 Other Staff").tag(JobDescription.OtherStaff)
                        Text("💩 Janitor").tag(JobDescription.janitor)
                    }
                    .pickerStyle(.menu)
                    
                    HStack {
                        Text("Choose your School:")
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
                    
                    Task {
                        do {
                            try await RegistrationViewModel.signUp(email: email, password: password)
                        } catch {
                            print("🥵 error in the button to register user: \(error)")
                        }
                        DatabaseService.setUserProfile(fullName: fullName, image: selectedImage, isJanitor: isJanitor, schoolCode: school.rawValue) { isSuccess in
                            if isSuccess {
                                
                                currentStep = .allSet
                            } else {
                                print("💩 loading failed")
                                isSaveButtonDisabaled = false
                            }
                        }
                    }
                    
                } label: {
                    Text(isSaveButtonDisabaled ? "Loading... ": "Save")
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
        }
    }
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        createAccountView(currentStep: .constant(.createAccount))
    }
}

