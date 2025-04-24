//
//  AddItemMenuWrapper.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 04.04.25.
//

import SwiftUI

internal enum AddType : CaseIterable {
    case calendar
    case routine
    case task
    case lesson
    case course
}

internal struct AddItemMenuWrapper<Content>: View where Content : View {
    
    internal let types : [AddType]
    
    internal let content : () -> Content
    
    @State private var addRoutineShown : Bool = false
    
    @State private var addTaskShown : Bool = false
    
    @State private var addCalendarEntryShown : Bool = false
    
    @State private var addProfileShown : Bool = false
    
    internal init(types : [AddType], @ViewBuilder content : @escaping () -> Content) {
        self.types = types
        self.content = content
    }
    
    var body: some View {
        content()
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Menu {
                        if types.contains(.routine) {
                            Button {
                                addRoutineShown.toggle()
                            } label: {
                                Label("Add Routine", systemImage: "clock")
                            }
                            Divider()
                        }
                        if types.contains(.task) {
                            Button {
                                addTaskShown.toggle()
                            } label: {
                                Label("Add Task", systemImage: "clipboard")
                            }
                            Divider()
                        }
                        if types.contains(.calendar) {
                            Button {
                                addCalendarEntryShown.toggle()
                            } label: {
                                Label("Add Calendar Entry", systemImage: "calendar")
                            }
                            Divider()
                        }
                        if types.contains(.lesson) {
                            Button {
                                
                            } label: {
                                Label("Add Lesson", systemImage: "calendar")
                            }
                            Divider()
                        }
                        if types.contains(.course) {
                            Button {
                                addCalendarEntryShown.toggle()
                            } label: {
                                Label("Add Course", systemImage: "graduationcap")
                            }
                            Divider()
                        }
                        Button {
                            addProfileShown.toggle()
                        } label: {
                            Label("Add Profile", systemImage: "person")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .popover(isPresented: $addRoutineShown) {
                AddRoutineView()
            }
            .sheet(isPresented: $addTaskShown) {
                
            }
            .sheet(isPresented: $addCalendarEntryShown) {
                AddCalendarEntryView()
            }
            .popover(isPresented: $addProfileShown) {
                AddProfileView()
            }
    }
}

#Preview {
    NavigationStack {
        AddItemMenuWrapper(types: AddType.allCases) {
            Text("Hello World!")
        }
        #if os(macOS)
        .frame(width: 500, height: 250)
        #endif
    }
}
