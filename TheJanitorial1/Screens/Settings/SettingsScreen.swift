//
//  SettingsScreen.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 4/1/23.
//

import SwiftUI


struct SettingsScreen: View {
    
    @EnvironmentObject private var loginVM: LoginViewModel

    @StateObject private var settingsVM = SettingsViewModel()
    
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
                    
//                    Button {
//                       isEditProfileFormShowing = true
//                    } label: {
//                        Text("Edit Profile")
//                    }

                    Button {
                        settingsVM.logOut()
                        loginVM.loginStatus = .isloggedOut

                    } label: {
                        Text("Log Out")
                    }
                }//Section

                    Section {
                        
                        Button {
                            Task{
                                do {
                                    print("👀 account deleted")
                                   try await settingsVM.deleteAccount()
                                    loginVM.loginStatus = .isloggedOut
                                    print("🧠 account deleted")
                                } catch {
                                    print(error)
                                    Text("to delete account, sign out and log back and then re-try to delete account")// make this display if the deleteAccount func is not working
                                }
                            }
                        } label: {
                            Text("Delete Account")
                                .foregroundColor(.red)
                        }
                    }//Section
            }//Form
        }//Main VStack
        .sheet(isPresented: $isEditProfileFormShowing) {
            EditProfileForm(settingsVM: settingsVM, isEditProfileFormShowing: $isSettingViewShowing)
                
        }
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen(isSettingViewShowing: .constant(false))
    }
}
