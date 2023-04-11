//
//  SettingsScreen.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 4/1/23.
//

import SwiftUI
// TODO: change profile details
// TODO: log out button


struct SettingsScreen: View {
    var body: some View {
        Form {
            Section {
                Text("Edit Profile")
                
                Text("Log Out")
            }
        }
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
    }
}
