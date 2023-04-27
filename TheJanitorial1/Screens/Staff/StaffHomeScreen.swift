//
//  SendTaskScreen.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 4/1/23.
//

import SwiftUI

struct StaffHomeScreen: View {
    // need to make this one an enviroment object, and figure out how to preload the data...or just leave it and change the other to stateObject to or obseverd object
    @EnvironmentObject private var sendTaskVM: SendTaskViewModel
    
    @State var isPresented = false
    @State private var isSettingsViewShowing = false
    
    var body: some View {
        
        VStack {
            ///Header
            HStack {
                
                ProfilePicView(currentUser: sendTaskVM.currentUser)
                
                if sendTaskVM.currentUser.fullName != nil {
                    Text(sendTaskVM.currentUser.fullName ?? "")
                        .font(.title)
                        .padding(.leading)
                } else {
                    ProgressView()
                        .padding(.leading)
                }
                
                Spacer()
                
                ///Settings Gear
                //TODO: change profile info, change email or password
                Button {
                    isSettingsViewShowing = true
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
            TaskContainer(isPresented: $isPresented)
//                .presentationDragIndicator(.visible)
        }
        .fullScreenCover(isPresented: $isSettingsViewShowing) {
                SettingsScreen(isSettingViewShowing: $isSettingsViewShowing)
        }
    }
}

struct SendTaskScreen_Previews: PreviewProvider {
    static var previews: some View {
        StaffHomeScreen()
    }
}
