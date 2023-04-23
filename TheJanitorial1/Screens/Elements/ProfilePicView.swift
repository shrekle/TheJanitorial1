//
//  ProfilePicView.swift
//  chatAppCWC
//
//  Created by adrian garcia on 3/30/23.
//

import SwiftUI

@MainActor//remove
struct ProfilePicView: View {
    
    var currentUser: UserModel?
    
    var cacheImage: Image? {
        CacheService.getImage(forKey: currentUser?.image ?? "")
    }
    var body: some View {
        
        ZStack {
            if currentUser == nil {
                ProgressView()
            }
            
            else if currentUser?.image == nil {
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                    Text(currentUser?.fullName?.prefix(1) ?? "")
                        .bold()
                }
            } else {
                
                if let cacheImage {
                    cacheImage
                    cacheImage.resizable()
                        .clipShape(Circle())
                        .scaledToFill()
                } else {
                    
                    let imageURL = URL(string: (currentUser?.image)!)
                    
                    AsyncImage(url: imageURL) { phase in
                        
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .clipShape(Circle())
                                .scaledToFill()
                                .onAppear {
                                    CacheService.setImage(image: image, forKey: (currentUser?.image)!)
                                }
                        case .failure:
                            ZStack {
                                Circle()
                                    .foregroundColor(.white)
                                Text(currentUser?.fullName?.prefix(1) ?? "")
                                    .bold()
                            }
                        @unknown default:
                            ZStack {
                                Circle()
                                    .foregroundColor(.white)
                                Text(currentUser?.fullName?.prefix(1) ?? "")
                                    .bold()
                            }
                        }
                    } // AsyncImage
                }
            }
            Circle()
                .stroke(.blue, lineWidth: 2)
            
        } // ZStack
        .frame(width: 44, height: 44)
    }
    
}

struct ProfilePicView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicView(currentUser: UserModel())
    }
}

