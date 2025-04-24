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
                    Text("Version")
                    Spacer()
                    Text(getAppVersion())
                }
                HStack {
                    Text("Build")
                    Spacer()
                    Text(getBuildVersion())
                }
            } header: {
                Text("App")
            } footer: {
                Text("Build with ❤️‍🔥 using Swift & SwiftUI")
            }
            Section {
                // Nothing, because this is only a text section definied in the footer of this section
            } header: {
                Text("Legal")
            } footer: {
                VStack(alignment: .leading) {
                    Text("© 2025 Julian Schumacher & Rachel Sprio")
                    Text("Privacy Policy and Data Security Policy can be found unter https://julianschumacher.dev/legal/privacy")
                }
            }
        }
    }
    
    private func getAppVersion() -> String {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return appVersion
        } else {
            return "Unkown"
        }
    }
    
    private func getBuildVersion() -> String {
        if let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            return buildVersion
        } else {
            return "Unkown"
        }
    }
}

#Preview {
    AboutSettingsView()
}
