//
//  EveryMinuteApp.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 16.01.25.
//

import SwiftUI

@main
struct EveryMinuteApp: App {
    let persistenceController = PersistenceController.shared
    
    /// The initial array of status bar objects
    @State internal static var statusBarObjects : [StatusbarItem] = [
        StatusbarItem(
            name: "Today",
            systemImage: "clock",
            displayed: true,
            position: 1,
            view: .today,
            dividerAfter: true
        ),
        StatusbarItem(
            name: "Home",
            systemImage: "house",
            displayed: true,
            position: 2,
            view: .home
        ),
        StatusbarItem(
            name: "Calendar",
            systemImage: "calendar",
            displayed: true,
            position: 3,
            view: .calendar
        ),
        StatusbarItem(
            name: "Tasks",
            systemImage: "clipboard",
            displayed: true,
            position: 4,
            view: .tasks
        )
    ]

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        #if os(macOS)
        Settings {
            SettingsView()
        }
        #endif
    }
}
