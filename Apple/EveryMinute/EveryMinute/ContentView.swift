//
//  ContentView.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 16.01.25.
//

import SwiftUI
import CoreData

internal struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            VStack(alignment: .leading, spacing: 16) {
                NavigationLink {
                    TodayView()
                } label: {
                    Label("Today", systemImage: "clock")
                }
                Divider()
                NavigationLink {
                    HomeView()
                } label: {
                    Label("Home", systemImage: "house")
                }
                NavigationLink {
                    
                } label: {
                    Label("Calendar", systemImage: "calendar")
                }
                NavigationLink {
                    
                } label: {
                    Label("Tasks", systemImage: "clipboard")
                }
                Spacer()
                #if os(macOS)
                NavigationLink {
                    SettingsLink()
                } label: {
                    Label("Settings", systemImage: "gear")
                }
                #endif
            }
            .buttonStyle(.plain)
            .padding(.all, 16)
            
        } content: {
            
        } detail: {
            
        }
        .navigationTitle("EveryMinute")
    }
}

#Preview {
    ContentView()
}
