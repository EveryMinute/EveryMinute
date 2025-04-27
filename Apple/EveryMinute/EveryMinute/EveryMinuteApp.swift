//
//  EveryMinuteApp.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 16.01.25.
//

import SwiftUI
import OSLog

@main
struct EveryMinuteApp: App {
    
    /// The shared persistence Controller with context to interact with core data used across the app
    private static let persistenceController = PersistenceController.shared
    
    /// The logger used to log important events and errors in the App
    internal static let logger : Logger = Logger()
    
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
                .environment(\.managedObjectContext, EveryMinuteApp.persistenceController.container.viewContext)
        }
        #if os(macOS)
        Settings {
            SettingsView()
        }
        #endif
    }
}
