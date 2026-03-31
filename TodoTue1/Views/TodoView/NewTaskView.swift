//
//  NewTaskView.swift
//  TodoTue1
//
//  Created by Shuvam Shrestha on 31/3/2026.
//

import SwiftUI

struct NewTaskView: View {
    
    @Binding var tasks: [TodoTask]
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var priority: Priority = .medium
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            Section {
                TextField("Task Title", text: $title)
                    .bold()
                TextEditor(text: $description)
            } header: {
                Text("Task Details")
            }
            Picker("Select Prioirity", selection: $priority) {
                ForEach(Priority.allCases, id: \.self) { priority in
                    Text(priority.rawValue)
                        .tag(priority)
                }
            }
        }
        .navigationTitle("New Task")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    addNewTask()
                    dismiss()
                } label: {
                    Label("Save", systemImage: "checkmark")
                }
                .buttonStyle(.borderedProminent)
                .disabled(!isValidForm)
            }
        }
    }
    
    private func addNewTask() {
        let newTask = TodoTask(title: title, description: description.isEmpty ? "No Description" : description, priority: priority)
        
        tasks.append(newTask)
    }
    
    private var isValidForm: Bool {
        if title.isEmpty {
            return false
        } else {
            return true
        }
    }
}
