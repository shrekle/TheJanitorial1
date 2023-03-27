//
//  VerificationView.swift
//  chatAppCWC
//
//  Created by adrian garcia on 3/15/23.
//

import SwiftUI
import Combine

struct createAccountView: View {
    
    @Binding var currentStep: registrationStep
    
    @State var verificationCode = ""
    
    var body: some View {
        
        VStack {
            
            Text("Verification")
                .font(.largeTitle)
                .padding(.top, 52)
            
            Text("Enter your code here...dawg")
                .font(.callout)
                .padding(.top, 12)
            
            //MARK: - TEXTFIELD
            ZStack {
                HStack  {
                    TextField("Enter your code here Big Dawg", text: $verificationCode)
                        .font(.callout)
                        .keyboardType(.numberPad)
                        .onReceive(Just(verificationCode)) { _ in
                            TextHelper.limitText(&verificationCode, 6)
                        }
                        .textFieldStyle(CreateProfileTextfieldStyle())
                    
                    Spacer()
                    
                    //MARK: - textfield button
                    Button {
                        verificationCode = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                    }
                    .tint(Color("iconsInputField"))
                    .frame(width: 19, height: 19)
                }
                .padding()
            }// Zstack Textfiled
            .padding(.top, 34)
            
            Spacer()
            
            //MARK: - next button
            Button {
                //send verification code to firebase
                AuthViewModel.verifyCode(verificationCode: verificationCode) { error in
                    if error == nil {
                        currentStep = .profile
                    } else {
                        //                            TODO: SHOW ERROR message
                        print("🤬 error verification button")
                    }
                }
            } label: {
                Text("Next")
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)
        }// vstack Main
        .padding(.horizontal)    }
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView(currentStep: .constant(.verification))
    }
}

