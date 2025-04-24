//
//  GeneralSettingsView.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 16.01.25.
//

import SwiftUI

struct GeneralSettingsView: View {
    
    @State private var statusBarItemsToOrder = EveryMinuteApp.statusBarObjects
    
    var body: some View {
        List {
            Section {
                ForEach($statusBarItemsToOrder, id: \.name, editActions: .move) {
                    item in
                    HStack {
                        Label(
                            item.name.wrappedValue,
                            systemImage: item.systemImage.wrappedValue
                        )
                        .foregroundStyle(.primary)
                        Spacer()
                        Toggle(isOn: item.displayed) { EmptyView() }
                    }
                }
                .onMove(perform: reorderSidebarItems)
            } header: {
                Text("Sidebar")
            } footer: {
                VStack(alignment: .leading) {
                    Text("Move the items to reorganize your sidebar")
                    Text("Select or deselect an item to show/hide it")
                }
            }
            Section {
                // TODO: change isOn
                Toggle("Sync with iCloud", isOn: .constant(true))
            } header: {
                Text("iCloud")
            } footer: {
                Text("Enable and manage iCloud Sync")
            }
        }
    }
    
    private func reorderSidebarItems(_ indexSet: IndexSet, to destination: Int) {
        statusBarItemsToOrder.move(fromOffsets: indexSet, toOffset: destination)
        for index in 0..<statusBarItemsToOrder.count {
            EveryMinuteApp.statusBarObjects[index].position = index + 1
        }
    }
}

#Preview {
    GeneralSettingsView()
}
