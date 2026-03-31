//
//  TodoTask.swift
//  TodoTue1
//
//  Created by Shuvam Shrestha on 31/3/2026.
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
    
    var icon: Image {
        switch self {
        case .low:
            Image(systemName: "exclamationmark")
        case .medium:
            Image(systemName: "exclamationmark.2")
        case .high:
            Image(systemName: "exclamationmark.3")
        }
    }
}
