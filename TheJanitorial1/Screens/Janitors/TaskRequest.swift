//
//  TaskRequest.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 4/4/23.
//

import SwiftUI

///show the actual task that was clicked

struct TaskRequest: View {
    
     var task: Todo
    
    var body: some View {
        VStack {
            ///heading
            Text("💩 Task Description:")
                .font(.title)
            
            Divider()
            
            Text(task.todo!)
            Text(task.eta!)
            Text(task.fullName!)
            Text(task.id!)



        }
    }
}

struct TaskRequest_Previews: PreviewProvider {
    static var previews: some View {
        TaskRequest(task: Todo())
    }
}
