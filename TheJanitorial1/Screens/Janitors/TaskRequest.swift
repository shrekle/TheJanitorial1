//
//  TaskRequest.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 4/4/23.
//

import SwiftUI

///show the actual task that was clicked

struct TaskRequest: View {
    
    @EnvironmentObject var taskListVM: TaskListViewModel
    
    var task: Todo
    var imageUrl: URL? {
        URL(string: task.imageUrl ?? "")
    }
    var eta: String {
        if task.eta == C.custom {
            return task.custom!
        } else {
            return task.eta!
        }
    }
    var cacheImage: Image? {
        CacheService.getImage(forKey: task.imageUrl ?? "")
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            ///heading
            HStack {
                
                
                ProfilePicView(currentUser: taskListVM.taskIntoUserModel(task: task))
                    .padding(.leading, 10)
                
                Spacer()
                
                Text(task.fullName!)
                    .font(.title)
                    .bold()
                    .padding(.trailing, 54)
                
                Spacer()
            }
            
            Divider()
                .padding(.horizontal)
            
            Text("ETA:")
                .bold()
                .padding(.top)
            
            Text(eta)
                .padding(.leading)
            
            Text("To doo-doo 💩:")
                .bold()
                .padding(.top)
            
            Text(task.todo!)
                .padding(.leading)
            
            if imageUrl != nil {
               
                Text("Image:")
                    .bold()
                    .padding(.top)
                
                if let cacheImage {
                    cacheImage
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 5)
                } else {
                    AsyncImage(url: imageUrl) {  phase in
                        
                        switch phase {
                        case .empty:
                            
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                            .padding(.top, 70)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 5)
                                                    .onAppear {
                                                        CacheService.setImage(image: image, forKey: task.imageUrl ?? "")
                                                    }
                        case .failure:
                            Image(uiImage: UIImage())
                            //                    ZStack {
                            //                        Circle()
                            //                            .foregroundColor(.white)
                            //                        Text(currentUser?.fullName?.prefix(1) ?? "")
                            //                            .bold()
                            //                    }
                        @unknown default:
                            Image(uiImage: UIImage())
                            //                    ZStack {
                            //                        Circle()
                            //                            .foregroundColor(.white)
                            //                        Text(currentUser?.fullName?.prefix(1) ?? "")
                            //                            .bold()
                            //                    }
                        }
                    }// Async Image
                }
            }
        
            
            Spacer()
            
        }//Main VStack
        .padding()
    }
}

struct TaskRequest_Previews: PreviewProvider {
    static var previews: some View {
        TaskRequest(task: Todo())
    }
}
