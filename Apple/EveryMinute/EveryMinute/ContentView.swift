//
//  ContentView.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 16.01.25.
//

import SwiftUI
import CoreData

internal struct ContentView: View {
    
    private var statusBarObjects : [StatusbarItem] = []
    
    var body: some View {
        NavigationSplitView {
#if os(iOS)
            List {
                sidebarList()
            }
            .navigationTitle("EveryMinute")
            .navigationBarTitleDisplayMode(.automatic)
#endif
#if os(macOS)
            Group {
                VStack(alignment: .leading, spacing: 20) {
                    sidebarList()
                }
                Spacer()
                SettingsLink {
                    Label("Settings", systemImage: "gear")
                }
            }
            .padding(.all, 16)
            .buttonStyle(.plain)
#endif
        } content: {
            TodayView()
        } detail: {
            Label("Select something to display more", systemImage: "questionmark")
        }
    }
    
    @ViewBuilder
    private func sidebarList() -> some View {
            NavigationLink {
                TodayView()
            } label: {
                Label("Today", systemImage: "clock")
            }
#if os(macOS)
            Divider()
#endif
            NavigationLink {
                HomeView()
            } label: {
                Label("Home", systemImage: "house")
            }
            NavigationLink {
                // TODO: add calendar
                Text("Not implemented yet")
                    .navigationTitle("Calendar")
            } label: {
                Label("Calendar", systemImage: "calendar")
            }
            NavigationLink {
                TasksView()
            } label: {
                Label("Tasks", systemImage: "clipboard")
            }
    }
}

#Preview {
    ContentView()
}
