//
//  RootView.swift
//  TodoTue1
//
//  Created by Shuvam Shrestha on 31/3/2026.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            TodoView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

#Preview {
    RootView()
}
