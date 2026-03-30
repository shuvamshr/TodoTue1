//
//  ContentView.swift
//  TodoTue1
//
//  Created by Shuvam Shrestha on 17/3/2026.
//

import SwiftUI

struct TodoTask: Identifiable {
    var id: UUID = UUID()
    var title: String = "Untitled"
    var description: String = "No Description Provided"
    var isCompleted: Bool = false
    var priority: Priority = .medium
}

enum Priority: String, CaseIterable {
    case low = "Low Priority"
    case medium = "Medium Priority"
    case high = "High Priority"
    
    var color: Color {
        switch self {
        case .low:
            Color.green
        case .medium:
            Color.orange
        case .high:
            Color.red
        }
    }
}


struct RootView: View {
    
    @State private var tasks: [TodoTask] = [
        TodoTask(
            title: "Organise workspace",
            description: "Clean desk and arrange files for better focus",
            priority: .low
        ),
        TodoTask(
            title: "Prepare presentation slides",
            description: "Finalize content and visuals for tomorrow's meeting",
            priority: .medium
        ),
        TodoTask(
            title: "Submit assignment",
            description: "Complete and upload before the deadline",
            isCompleted: true,
            priority: .high
        ),
        TodoTask(
            title: "Read a few pages",
            description: "Spend 15 minutes reading a book before bed",
            priority: .low
        )
    ]
    
    var body: some View {

        NavigationStack {
            List {
                ForEach(tasks) { task in
                    TaskItemView(task: task)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Things To-Do")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        NewTaskView(tasks: $tasks)
                    } label: {
                        Label("Add New Task", systemImage: "plus")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}

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

struct TaskItemView: View {
    
    var task: TodoTask
    
    var body: some View {
        
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text(task.priority.rawValue)
                    .font(.caption2)
                    .fontWeight(.heavy)
                    .foregroundStyle(task.priority.color)
                Text(task.title)
                    .font(.headline)
                    .foregroundStyle(Color.primary)
                Text(task.description)
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
            }
            
            Spacer()
            
            if task.isCompleted {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title)
                    .foregroundStyle(Color.green)
            } else {
                Image(systemName: "circle")
                    .font(.title)
                    .foregroundStyle(Color.secondary.opacity(0.5))
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    RootView()
}
