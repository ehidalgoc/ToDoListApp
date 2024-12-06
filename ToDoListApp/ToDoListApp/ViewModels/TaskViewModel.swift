//
//  TaskViewModel.swift
//  ToDoListApp
//
//  Created by BPIMA_ALW1090 on 12/4/24.
//
import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    
    // Method to add a new task
    func addTaskToTheToDoList(description: String) {
        guard !description.isEmpty else { return }
        let newTask = Task(description: description, isCompleted: false)
        tasks.append(newTask)
    }
    
    // Method to delete a task
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    // Method to update a task (toggle completion)
    fileprivate func extractedFunc(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
    
    func toggleTaskCompletion(task: Task) {
        extractedFunc(task)
    }
    
}
