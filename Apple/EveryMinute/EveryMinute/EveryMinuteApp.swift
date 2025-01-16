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
