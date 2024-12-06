//
//  EditToDoView.swift
//  ToDoListApp
//
//  Created by BPIMA_ALW1090 on 12/6/24.
//
import SwiftUI

struct EditToDoView: View {
    @Binding var isPresented: Bool
    @Binding var selectedTask: Task
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("To-Do Details")) {
                    
                    TextField("Description", text: $selectedTask.description)
                }
            }
            .navigationTitle("Edit To-Do")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct EditToDoView_Previews: PreviewProvider {
    @State static var isPresented = true
    @State static var sampleTask = Task(description: "Sample Task", isCompleted: false)

    static var previews: some View {
        EditToDoView(
            isPresented: $isPresented,
            selectedTask: $sampleTask
        )
    }
}
