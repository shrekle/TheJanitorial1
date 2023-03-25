//
//  CreateProfileView.swift
//  chatAppCWC
//
//  Created by adrian garcia on 3/15/23.
//

import SwiftUI

struct CreateProfileView: View {
        
    @EnvironmentObject var model: LoginViewModel
    
    @Binding var currentStep: registrationStep
    
    @State var firstName = ""
    @State var lastName = ""
    
    @State var selectedImage: UIImage?
    @State var isPickerShowing = false
    
    @State var isSourceMenuShowing = false
    @State var source: UIImagePickerController.SourceType = .photoLibrary
    
    @State private var isSaveButtonDisabaled = false
    
    var body: some View {
        
        VStack {
            
            Text("Set Up Profile")
                .font(.largeTitle)
                .padding(.top, 52)
            
            Text("Calm your pits Beca")
                .font(.callout)
                .padding(.top, 12)
            
            Spacer()
            
            //MARK: - profile image button
            Button {
                isSourceMenuShowing = true
            } label: {
                ZStack {    //  camara circle
                    if let selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                    }
                    else {
                        Circle()//  need to use a circle before the stroke outline to be able to color the backgorund of it white...the backgorund of the screen will be gray
                            .foregroundColor(.white)
                        
                        Image(systemName: "camera.fill")
                            .tint(Color("iconsInputField"))
                    }
                    //                        .overlay {
                    //                            Circle().stroke(lineWidth: 2)
                    //                                .foregroundColor(Color("createProfileBorder"))
                    //                        }
                    Circle()
                        .stroke(.blue , lineWidth: 2)
                }   //  Zstack camara circle
                .frame(width: 134, height: 134)
            }
            Spacer()
            
            TextField("name", text: $firstName)
                .textFieldStyle(CreateProfileTextfieldStyle())
            
            TextField("last name", text: $lastName)
                .textFieldStyle(CreateProfileTextfieldStyle())
            
            Spacer()
            
            //MARK: - SAVE BUTTON
            Button {
                isSaveButtonDisabaled = true
            
                DatabaseService.setUserProfile(firstName: firstName, lastName: lastName, image: selectedImage) { isSuccess in
                    if isSuccess {
                        
                        currentStep = .allSet
                    } else {
                        print("💩 loading failed")
                        isSaveButtonDisabaled = false
                    }
                }

            } label: {
                Text(isSaveButtonDisabaled ? "Loading... ": "Save")
            }
            .buttonStyle(OnboardingButtonStyle())
            .disabled(isSaveButtonDisabaled)
            .padding(.bottom, 87)
        }// vstack Main
        .padding(.horizontal)
        
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
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView(currentStep: .constant(.allSet))
    }
}
