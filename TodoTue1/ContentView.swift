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
    case urgent = "Urgent Priority"
}


struct RootView: View {
    
    // var tasks: [String] = ["Do this", "Do that", "And that"]
    
    @State private var tasks: [TodoTask] = [
        TodoTask(title: "My First Task is something", description: "Some description about this task"),
        TodoTask(title: "My Second Task", description: "Some description about this task"),
        TodoTask(title: "My Third Task", description: "Some description about this task", isCompleted: true),
        TodoTask()
    ]
    
    var body: some View {
        
        // for task in tasks { task.title, task.description, task.isCompleted }
        NavigationStack {
            ScrollView {
                ForEach(tasks) { task in
                    TaskItemView(task: task)
                }
                
            
            }
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
            TextField("Enter Your Task Title", text: $title)
            TextEditor(text: $description)
            Picker("Select Prioirity", selection: $priority) {
                ForEach(Priority.allCases, id: \.self) { priority in
                    Text(priority.rawValue)
                        .tag(priority)
                }
            }
        }
        .navigationTitle("New Task Form")
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
        
        // (V)ertically, (H)orizontal, (Z)-Index
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Button(task.priority.rawValue) {
                    
                }
                .controlSize(.mini)
                .buttonStyle(.borderedProminent)
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
                    .foregroundStyle(Color.secondary)
                
            }
        }
        .padding()
    }
}


#Preview {
    RootView()
}
