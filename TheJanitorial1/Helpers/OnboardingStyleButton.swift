//
//  OnboardingStyleButton.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 3/21/23.
//

import SwiftUI

struct OnboardingButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Rectangle()
                .frame(height: 50)
                .cornerRadius(5)
                .foregroundColor(.blue)
            
            configuration.label//   this is for the buttons text
//                .font(.button)
                .foregroundColor(.white)
        }
    }
}
