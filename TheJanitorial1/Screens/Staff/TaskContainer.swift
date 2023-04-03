//
//  TaskContainer.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 4/1/23.
//

import SwiftUI

enum TaskSendingStatus {
    case fillOut
    case isSent
}

struct TaskContainer: View {
        
    @State var taskStatus = TaskSendingStatus.fillOut
    
    var body: some View {
        
        VStack {
            
            Image(systemName: "chevron.compact.down")
                .resizable()
                .scaledToFit()
                .frame(width: 50)
                .foregroundColor(.blue)
                .padding(.top)
            
            switch taskStatus {
            case .fillOut:
                TaskFormScreen(taskStatus: $taskStatus)
            case .isSent:
                TaskSentScreen()
            }
        }//main
       
    }
}

struct TaskContainer_Previews: PreviewProvider {
    static var previews: some View {
        TaskContainer()
    }
}
