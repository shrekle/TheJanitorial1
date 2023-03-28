//
//  TaskListVM.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 3/27/23.
//

import Foundation

class TaskListVM: ObservableObject {
    
    @Published var tasks = [String]() // make task object
    @Published var isPresented = false
    
}
