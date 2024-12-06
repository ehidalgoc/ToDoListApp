//
//  ContentView.swift
//  ToDoListApp
//
//  Created by BPIMA_ALW1090 on 12/4/24.
//

import SwiftUI

import Foundation


struct TaskListView: View {
    @StateObject var viewModel = TaskViewModel()
    @State private var newTaskName: String = ""
    @State private var selectedTasks: Set<UUID> = []
    @State private var showButton: Bool = false
    @State private var isValidTaskDescription: Bool = true
    @State private var messageTextField: String = "Enter a new task"
    @State private var editButton: Bool = false;
    @State private var selectedTask: Task
    @State private var isSheetPresented: Bool = false
    
    // Add a custom initializer
   init(viewModel: TaskViewModel, selectedTask: Task) {
       _viewModel = StateObject(wrappedValue: viewModel)
       _selectedTask = State(wrappedValue: selectedTask)
   }
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                TextField(messageTextField, text: $newTaskName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background( isValidTaskDescription ? Color.gray.opacity(0.1): Color.red.opacity(0.2))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 2)
                    ).onChange(of: newTaskName) { newValue in
                        // Perform validation when the input changes
                        if !newTaskName.isEmpty && newTaskName.count > 5 {
                            isValidTaskDescription = true
                            messageTextField = "Enter a new task"
                        }
                    }
                
                
                Spacer()
                Spacer()
                // Add Task Button
                Button("Add Task") {
                    if !newTaskName.isEmpty { // Avoid empty and
                        viewModel.addTaskToTheToDoList(description: newTaskName)
                        newTaskName = "" // Clear the input
                    }else{
                        isValidTaskDescription = false
                        messageTextField = "Enter a valid description for new task"
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Rectangle()
                    .fill(.black)
                    .frame(height: 1)
                    .padding(.init(top: 10, leading: 0, bottom: 12, trailing: 0))
                
                List {
                    ForEach(viewModel.tasks, id: \.self) { task in
                        
                        HStack {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.isCompleted ? .green : .gray)
                                .onTapGesture {
                                    viewModel.toggleTaskCompletion(task: task)
                                    toggleSelection(for: task)
                                    showButton = true
                                    selectedTask = task
                                }
                            
                            Text(task.description)
                                .strikethrough(task.isCompleted, color: .gray)
                            Spacer()
                            
                            
                        }
                        
                        Rectangle()
                            .fill(.black)
                            .frame(height: 1)
                            .padding(.init(top: 10, leading: 0, bottom: 12, trailing: 0))
                    }
                    HStack {
                        if showButton && !selectedTasks.isEmpty {
                            // Button to delete selected items
                            
                                Spacer()
                                Button("Delete") {
                                    removeSelectedTasks()
                                }
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                Spacer()
                               
                            
                           /** Button(action: {
                                editButton.toggle()
                                //isSheetPresented = true
                                
                            }, label: {
                               Text("Edit Task")
                                
                            })
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            // The sheet modifier
                            .sheet(isPresented: $editButton) {
                                
                                EditToDoView(isPresented: $editButton, selectedTask: $selectedTask)
                                
                                
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 60))
                                    .foregroundColor(
                                        Color(
                                            red: 0.204,
                                            green: 0.553,
                                            blue: 0.22,
                                            opacity: 1
                                        )
                                    )
                            }**/
                           
                        }
                       
                        
                    
                    }.padding(.top)
                    
                }
            }
            .navigationTitle("Task List")
            .padding()
            
        }//natigation view
    }//body
    
    // Toggle task selection
    func toggleSelection(for task: Task) {
        if selectedTasks.contains(task.id) {
            selectedTasks.remove(task.id)
        } else {
            selectedTasks.insert(task.id)
        }
    }
   
    // Remove selected tasks from the tasks array
    func removeSelectedTasks() {
        viewModel.tasks.removeAll { task in
            selectedTasks.contains(task.id) // Remove tasks whose ids are in selectedTasks
        }
        selectedTasks.removeAll() // Clear the selection after removing tasks
    }
}//view




struct TaskListView_Previews: PreviewProvider {
    @StateObject static var previewViewModel = TaskViewModel()
    @State static var previewSelectedTask = Task(description: "Preview Task", isCompleted: false)

    static var previews: some View {
        TaskListView(
            viewModel: previewViewModel,
            selectedTask: previewSelectedTask
        )
    }
}

