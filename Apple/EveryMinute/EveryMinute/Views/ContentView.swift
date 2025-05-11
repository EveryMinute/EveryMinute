//
//  ContentView.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 16.01.25.
//

import SwiftUI

internal struct ContentView: View {
    
    @State private var addShown : Bool = false
    
    var body: some View {
        NavigationSplitView {
#if os(iOS)
            AddItemMenuWrapper(types: AddType.allCases) {
                List {
                    sidebarList()
                }
                .navigationTitle("EveryMinute")
                .navigationBarTitleDisplayMode(.automatic)
            }
#elseif os(macOS)
            VStack {
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
            ViewWrapper(types: AddType.allCases, view: .today)
        } detail: {
            Label("Select something to display more", systemImage: "questionmark")
        }
    }
    
    @ViewBuilder
    private func sidebarList() -> some View {
        let localStatusBarObjects = EveryMinuteApp.statusBarObjects.sorted {
            $0.position < $1.position
        }
        ForEach(localStatusBarObjects, id: \.name) {
            statusBarObject in
            if statusBarObject.displayed {
                NavigationLink {
                    // TODO: add types
                    ViewWrapper(types: [], view: statusBarObject.view)
                } label: {
                    Label(
                        statusBarObject.name,
                        systemImage: statusBarObject.systemImage
                    )
                    .foregroundStyle(.primary)
                }
            }
#if os(macOS)
            if statusBarObject.dividerAfter {
                Divider()
            }
#endif
        }
    }
}

#Preview {
    ContentView()
}
