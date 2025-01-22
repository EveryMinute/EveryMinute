//
//  TasksView.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 16.01.25.
//

import SwiftUI

struct TasksView: View {
    
    var body: some View {
        List {
            Section("Tasks") {
                
            }
            Section("Routines") {
                
            }
        }
        .navigationTitle("Tasks")
#if os(iOS)
        .navigationBarTitleDisplayMode(.automatic)
#endif
    }
}

#Preview {
    TasksView()
}
