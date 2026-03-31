//
//  EditTaskView.swift
//  TodoTue1
//
//  Created by Shuvam Shrestha on 31/3/2026.
//

import SwiftUI

struct EditTaskView: View {
    
    @Binding var tasks: [TodoTask]
    
    var task: TodoTask
    
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
        .navigationTitle("Edit Task")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    updateTask()
                    dismiss()
                } label: {
                    Label("Save", systemImage: "checkmark")
                }
                .buttonStyle(.borderedProminent)
                .disabled(!isValidForm)
            }
        }
        .onAppear {
            title = task.title
            description = task.description
            priority = task.priority
        }
    }
    
    
    
    private var isValidForm: Bool {
        if title.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    private func updateTask() {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            withAnimation {
                let updatedTask = TodoTask(id: task.id, title: title, description: description, isCompleted: task.isCompleted, priority: priority)
                
                tasks[index] = updatedTask
            }
        }
    }
}
