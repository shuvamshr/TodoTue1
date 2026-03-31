//
//  TaskItemView.swift
//  TodoTue1
//
//  Created by Shuvam Shrestha on 31/3/2026.
//

import SwiftUI

struct TaskItemView: View {
    
    @Binding var tasks: [TodoTask]
    
    var task: TodoTask
    
    var body: some View {
        
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    task.priority.icon
                    Text(task.priority.rawValue)
                }
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
            
            Button {
                updateTask()
            } label: {
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
        }
        .padding(.vertical, 4)
    }
    
    private func updateTask() {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            withAnimation {
                tasks[index].isCompleted.toggle()
            }
        }
    }
}
