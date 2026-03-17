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
}


struct RootView: View {
    
    // var tasks: [String] = ["Do this", "Do that", "And that"]
    
    var tasks: [TodoTask] = [
        TodoTask(title: "My First Task is something", description: "Some description about this task"),
        TodoTask(title: "My Second Task", description: "Some description about this task"),
        TodoTask(title: "My Third Task", description: "Some description about this task", isCompleted: true),
    ]
    
    var body: some View {
        
        // for task in tasks { task.title, task.description, task.isCompleted }
        ScrollView {
            ForEach(tasks) { task in
                TaskItemView(title: task.title, description: task.description, isCompleted: task.isCompleted)
            }
        }
        
    }
}

struct TaskItemView: View {
    
    var title: String
    var description: String
    var isCompleted: Bool
    
    var body: some View {
        
        // (V)ertically, (H)orizontal, (Z)-Index
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text(self.title)
                    .font(.headline)
                    .foregroundStyle(Color.primary)
                Text(self.description)
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
            }
            Spacer()
            
            if self.isCompleted {
                
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
