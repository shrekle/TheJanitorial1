//
//  RegistrationContainerView.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 3/21/23.
//

import SwiftUI

enum registrationStep: Int {
    case phoneNumber = 0
    case verification = 1
    case profile = 2
    case allSet = 3
}

struct RegistrationContainerView: View {
    
    @State var currentStep: registrationStep = .phoneNumber
   
    var body: some View {
        ZStack {
            
            Color(.lightGray) // use school colors, maybe yellow or blue
                .opacity(0.05)
                .ignoresSafeArea()
            
            switch currentStep {
            case .phoneNumber:
                PhoneNumberScreen(currentStep: $currentStep)
            case .verification:
                VerificationView(currentStep: $currentStep)
            case .profile:
                CreateProfileView(currentStep: $currentStep)
            case .allSet:
                AllSetView()
            }
        }
    }
}

struct RegistrationContainerView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationContainerView()
    }
}
