//
//  ContentView.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 16.01.25.
//

import SwiftUI
import CoreData

internal struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationSplitView {
            VStack(alignment: .leading, spacing: 10) {
                Label("Today", systemImage: "clock")
                Divider()
                Label("Home", systemImage: "house")
                Label("Calendar", systemImage: "calendar")
                Label("Tasks", systemImage: "clipboard")
            }
            .padding(.all, 16)
            Spacer()
        } detail: {
            
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
