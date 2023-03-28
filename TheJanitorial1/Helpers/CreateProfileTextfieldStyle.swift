//
//  TextfieldStyle.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 3/21/23.
//

import SwiftUI

struct CreateProfileTextfieldStyle: TextFieldStyle {
   
   @Binding var buttonText: String
    
    func _body(configuration: TextField<Self._Label>)-> some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(8)
                .frame(height: 46)
                .shadow(radius: 5).opacity(0.2)
            
            HStack {
                
                Spacer()
                
                Button {
                    buttonText = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(Color(.lightGray))
                }
                .padding(.trailing, 5)
            }
            configuration
                .padding(.leading, 10)
                // maybe import the font from the chat app CWC
        }
    }
}
