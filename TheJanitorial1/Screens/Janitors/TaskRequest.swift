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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
    }
}

struct TaskRequest_Previews: PreviewProvider {
    static var previews: some View {
        TaskRequest(task: Todo())
    }
}
