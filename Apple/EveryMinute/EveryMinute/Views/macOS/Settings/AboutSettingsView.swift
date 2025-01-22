//
//  AboutSettingsView.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 16.01.25.
//

import SwiftUI

struct AboutSettingsView: View {
    var body: some View {
        List {
            Section {
                HStack {
                    Text("version")
                    Spacer()
                    Text("TODO: add app version")
                }
                HStack {
                    Text("build")
                    Spacer()
                    Text("TODO: add build version")
                }
            } header: {
                Text("App")
            } footer: {
                Text("Build with ❤️‍🔥 using Swift & SwiftUI")
            }
            Section {
                
            } header: {
                Text("Legal")
            } footer: {
                Text("© 2025 Julian Schumacher")
            }
        }
    }
}

#Preview {
    AboutSettingsView()
}
