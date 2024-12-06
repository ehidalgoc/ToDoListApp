//
//  ToDoListAppApp.swift
//  ToDoListApp
//
//  Created by BPIMA_ALW1090 on 12/4/24.
//

import SwiftUI

@main
struct ToDoListMVVMApp: App {
    @StateObject static var previewViewModel = TaskViewModel()
    @State static var previewSelectedTask = Task(description: "Preview Task", isCompleted: false)
    
    var body: some Scene {
        WindowGroup {
            TaskListView(
                viewModel: ToDoListMVVMApp.previewViewModel, selectedTask: ToDoListMVVMApp.previewSelectedTask
            )
        }
    }
}
