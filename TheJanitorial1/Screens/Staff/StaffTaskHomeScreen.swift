//
//  SendTaskScreen.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 4/1/23.
//

import SwiftUI


//TODO: have the bottom sheet diplay a big green circle check mark to let the user know that the  task was sent successfully

struct StaffTaskHomeScreen: View {
    
    @StateObject var VMsendTask = SendTaskViewModel()
    
    @State var isPresented = false
    @State var taskSent = false
    
    var body: some View {
        
        VStack {
            ///Header
            HStack {
                ProfilePicView(user: VMsendTask.user)
                
                Text(VMsendTask.user.fullName ?? "name is nil")
                    .font(.title)
                    .padding(.leading)
                
                Spacer()
                
                ///Settings Gear
                //TODO: change profile info, change email or password
                Button {
                    AuthViewModel.logOut()
                } label: {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }//Hstack
            
            Spacer()
            ///Add task
            Button {
                isPresented = true
            } label: {
                ///Maybe put the school logo instead of the color, but low opacity
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
            }
            
            Spacer()
        }//main
        .padding(.horizontal)
        .sheet(isPresented: $isPresented) {
            TaskContainer()
                .presentationDragIndicator(.visible)
        }
    }
}

struct SendTaskScreen_Previews: PreviewProvider {
    static var previews: some View {
        StaffTaskHomeScreen()
    }
}
