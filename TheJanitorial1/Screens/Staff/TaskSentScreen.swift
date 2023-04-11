//
//  TaskSentScreen.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 4/1/23.
//

import SwiftUI

struct TaskSentScreen: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "checkmark.seal.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.green)
                .frame(width: 100)
            
            Text("Task Sent !")
            
            Spacer()
        }
    }
}

struct TaskSentScreen_Previews: PreviewProvider {
    static var previews: some View {
        TaskSentScreen(isPresented: .constant(false))
    }
}
