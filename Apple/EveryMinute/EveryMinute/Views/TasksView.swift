//
//  TasksView.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 16.01.25.
//

import SwiftUI

internal struct TasksView: View {
    
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.name)]
    ) private var assignments : FetchedResults<Assignment>
    
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.name)]
    ) private var routines : FetchedResults<Routine>
    
    var body: some View {
        List {
            Section("Assignments") {
                Text("Test")
                ForEach(assignments) {
                    assignment in
                    assignmentsContainer(assignment)
                }
            }
            Section("Routines") {
                ForEach(routines) {
                    routine in
                    routineContainer(routine)
                }
            }
        }
        .navigationTitle("Tasks")
#if os(iOS)
        .navigationBarTitleDisplayMode(.automatic)
#endif
    }
    
    @ViewBuilder
    private func assignmentsContainer(_ assignment : Assignment) -> some View {
        HStack {
            Image(systemName: assignment.completed ? "checkmark.circle" : "circle")
            Text(assignment.name!)
        }
    }
    
    @ViewBuilder
    private func routineContainer(_ routine : Routine) -> some View {
        // TODO: implement routine Container
    }
}

#Preview {
    NavigationStack {
        TasksView()
    }
}
