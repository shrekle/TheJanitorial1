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
    
    @Binding var isPresented: Bool
    
    var body: some View {
        
        VStack {
            HStack {
                
                Text("Done") // this is used only for correct spacing
                    .font(.title2)
                    .bold()
                    .foregroundColor(.clear)
                    .padding(.leading)
                    .padding(.top)
                
                Spacer()
                
                Image(systemName: "chevron.compact.down")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .foregroundColor(.blue)
                    .padding(.top)
                
                Spacer()
                
                if taskStatus == .isSent {
                    Button {
                        isPresented = false
                    } label: {
                        Text("Done")
                            .font(.title2)
                            .bold()
                            .padding(.trailing)
                            .padding(.top)
                    }
                } else {
                    Text("Done")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.clear)
                        .padding(.trailing)
                        .padding(.top)
                }
            }
           
            switch taskStatus {
            case .fillOut:
                TaskFormScreen(taskStatus: $taskStatus)
            case .isSent:
                TaskSentScreen(isPresented: $isPresented)
            }
        }//main
    }
}

struct TaskContainer_Previews: PreviewProvider {
    static var previews: some View {
        TaskContainer(isPresented: .constant(false))
    }
}
