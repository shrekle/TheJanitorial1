//
//  SettingsScreen.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 4/1/23.
//

import SwiftUI

struct SettingsScreen: View {
    
    @Binding var isSettingViewShowing: Bool
    
    @State var isEditProfileFormShowing = false
    
    var body: some View {
        
        VStack {
            HStack {
                Button {
                    isSettingViewShowing = false
                } label: {
                    Image(systemName: "arrow.backward")
                }
                
                Spacer()
                
                Text("Settings")
                    .font(.title)
                    .padding(.leading, 50)
                
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.leading, 40)
                
                Spacer()
                
            }//Hstack
            .padding(.horizontal)
            
            Form {
                
                Section {
                    
                    Button {
                       isEditProfileFormShowing = true
                    } label: {
                        Text("Edit Profile")
                    }

                    Button {
                        AuthViewModel.logOut()
                    } label: {
                        Text("Log Out")
                    }
                }//Section

                    Section {
                        
                        Button {
                            AuthViewModel.logOut()
                        } label: {
                            Text("Delete Account")
                                .foregroundColor(.red)
                        }
                    }//Section
            }//Form
        }//Main VStack
        .sheet(isPresented: $isEditProfileFormShowing) {
            EditProfileForm()
                
        }
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen(isSettingViewShowing: .constant(false))
    }
}
