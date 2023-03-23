//
//  RegisterScreen.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 2/1/23.
//

import SwiftUI
import Combine

/// use the tutorial from sean allen swiftUI form, it has all that i need to make the request form for teachers to fill out and send me with a task
///
struct PhoneNumberScreen: View {
    
    @Binding var currentStep: registrationStep
    
    @State var phoneNumber = ""
        
        var body: some View {
            
            VStack {
                
                Text("Verification")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 52)
                
                Text("Enter you phone number, ill send a notification code")
                    .font(.callout)
                    .padding(.top, 12)
                
                //MARK: - TEXTFIELD
                ZStack {
                    HStack  {
                        TextField("Chumbawamba", text: $phoneNumber)
//                            .font(.bodyText)
                            .textFieldStyle(CreateProfileTextfieldStyle())
                            .keyboardType(.numberPad)
                            .onReceive(Just(phoneNumber)) { _ in
                                TextHelper.applyPatternOnNumbers(&phoneNumber, pattern: "+# (###) ###-####", replacementCharacter: "#")
                            }
                        
                        Spacer()
                        
                        //MARK: - textfield button
                        Button {
                            phoneNumber = ""
                        } label: {
                            Image(systemName: "multiply.circle.fill")
                        }
                        .tint(Color(.lightGray))
                        .frame(width: 19, height: 19)
                    }
                    .padding()
                }// Zstack Textfiled
                .padding(.top, 34)
                
                Spacer()
                
                //MARK: - next button
                Button {
                    AuthViewModel.sendPhoneNumber(phoneNumber) { error in
                        if error == nil {
                            currentStep = .verification
                        } else { print("🎃 error sending number: \(String(describing: error))")}
                    }
                } label: {
                    Text("Next")
                }
                .buttonStyle(OnboardingButtonStyle())
                .padding(.bottom, 87)
            }// vstack Main
            .padding(.horizontal)
        }
    }

struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberScreen(currentStep: .constant(.phoneNumber))
    }
}
