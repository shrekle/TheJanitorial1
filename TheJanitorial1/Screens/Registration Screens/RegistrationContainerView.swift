//
//  RegistrationContainerView.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 3/21/23.
//

import SwiftUI

enum registrationStep: Int {
    case createAccount = 1
    case allSet = 2
}

struct RegistrationContainerView: View {
    
    @State var currentStep: registrationStep = .createAccount
   
    var body: some View {
        ZStack {
            
            Color(.lightGray) // use school colors, maybe yellow or blue
                .opacity(0.05)
                .ignoresSafeArea()
            
            switch currentStep {
            case .createAccount:
                createAccountView(currentStep: $currentStep)
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
