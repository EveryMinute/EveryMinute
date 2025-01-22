//
//  SettingsView.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 16.01.25.
//

import SwiftUI

internal struct SettingsView: View {
    var body: some View {
        TabView {
            Tab("General", systemImage: "gear") {
                GeneralSettingsView()
            }
//            Tab("Advanced", systemImage: "plus") {
//            }
            Tab("About", systemImage: "info") {
                AboutSettingsView()
            }
        }
    }
}

#Preview {
    SettingsView()
}
