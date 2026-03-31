//
//  ContentView.swift
//  TodoTue1
//
//  Created by Shuvam Shrestha on 17/3/2026.
//

import SwiftUI


struct TodoView: View {
    
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
                    TaskItemView(tasks: $tasks, task: task)
                        .swipeActions(edge: .trailing) {
                            NavigationLink {
                                EditTaskView(tasks: $tasks, task: task)
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(Color.accent)
                            
                            Button("Delete", systemImage: "trash.fill") {
                                deleteTask(task: task)
                            }
                            .tint(Color.red)
                        }
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
    
    private func deleteTask(task: TodoTask) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            withAnimation {
                tasks.remove(at: index)
            }
        }
    }
}


#Preview {
    RootView()
}
