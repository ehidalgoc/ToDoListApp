//
//  Task.swift
//  ToDoListApp
//
//  Created by BPIMA_ALW1090 on 12/5/24.
//
import Foundation

struct Task: Identifiable, Codable, Hashable {
    var id = UUID()
    var description: String
    var isCompleted: Bool
    
}
