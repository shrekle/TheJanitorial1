//
//  ProfilePicView.swift
//  chatAppCWC
//
//  Created by adrian garcia on 3/30/23.
//

import SwiftUI

struct ProfilePicView: View {
    
    var user: UserModel
    
    var body: some View {
        
        ZStack {
            if user.image == nil {
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                    Text(user.fullName?.prefix(1) ?? "image is nil")
                        .bold()
                }
            } else {
                
                let imageURL = URL(string: user.image ?? "")
                
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .clipShape(Circle())
                            .scaledToFill()
                    case .failure:
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                            Text(user.fullName?.prefix(1) ?? "")
                                .bold()
                        }
                    @unknown default:
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                            Text(user.fullName?.prefix(1) ?? "")
                                .bold()
                        }
                    }
                } // AsyncImage
            }
          
            Circle()
                .stroke(.blue, lineWidth: 2)
            
        } // ZStack
        .frame(width: 44, height: 44)
        
    }
}

struct ProfilePicView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicView(user: UserModel())
    }
}
