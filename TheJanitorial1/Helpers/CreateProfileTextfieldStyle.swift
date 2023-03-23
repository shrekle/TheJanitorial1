//
//  TextfieldStyle.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 3/21/23.
//

import SwiftUI

struct CreateProfileTextfieldStyle: TextFieldStyle {
   
    func _body(configuration: TextField<Self._Label>)-> some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(8)
                .frame(height: 46)
            
            configuration
                // maybe import the font from the chat app CWC
                .padding()
        }
    }
}
