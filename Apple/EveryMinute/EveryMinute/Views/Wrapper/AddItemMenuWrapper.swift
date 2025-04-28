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
    case chapter
}

internal struct AddItemMenuWrapper<Content>: View where Content : View {
    
    internal let types : [AddType]
    
    internal let content : () -> Content
    
    @State private var addRoutineShown : Bool = false
    
    @State private var addTaskShown : Bool = false
    
    @State private var addCalendarEntryShown : Bool = false
    
    @State private var addCourseShown : Bool = false
    
    @State private var addProfileShown : Bool = false
    
    @State private var addLessonShown : Bool = false
    
    @State private var addChapterShown : Bool = false
    
    internal init(types : [AddType], @ViewBuilder content : @escaping () -> Content) {
        self.types = types
        self.content = content
    }
    
    var body: some View {
        content()
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Menu {
                        /* Routine */
                        if types.contains(.routine) {
                            Button {
                                addRoutineShown.toggle()
                            } label: {
                                Label("Add Routine", systemImage: "clock")
                            }
                            Divider()
                        }
                        
                        /* Task */
                        if types.contains(.task) {
                            Button {
                                addTaskShown.toggle()
                            } label: {
                                Label("Add Task", systemImage: "clipboard")
                            }
                            .popover(isPresented: $addTaskShown) {
                                // TODO: implement Add Task View
                            }
                            Divider()
                        }
                        
                        /* Calendar */
                        if types.contains(.calendar) {
                            Button {
                                addCalendarEntryShown.toggle()
                            } label: {
                                Label("Add Calendar Entry", systemImage: "calendar")
                            }
                            Divider()
                        }
                        
                        /* Lesson */
                        if types.contains(.lesson) {
                            Button {
                                addLessonShown.toggle()
                            } label: {
                                Label("Add Lesson", systemImage: "calendar")
                            }
                            Divider()
                        }
                        
                        /* Course */
                        if types.contains(.course) {
                            Button {
                                addCourseShown.toggle()
                            } label: {
                                Label("Add Course", systemImage: "graduationcap")
                            }
                            Divider()
                        }
                        
                        /* Chapter */
                        if types.contains(.chapter) {
                            Button {
                                addChapterShown.toggle()
                            } label: {
                                Label("Add Chapter", systemImage: "calendar.badge.clock")
                            }
                            Divider()
                        }
                        
                        /* Profile */
                        Button {
                            addProfileShown.toggle()
                        } label: {
                            Label("Add Profile", systemImage: "person")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                    .popover(isPresented: $addRoutineShown) {
                        AddRoutineView(type: .routine)
                    }
                    .popover(isPresented: $addCalendarEntryShown) {
                        AddRoutineView(type: .calendarEntry)
                    }
                    .popover(isPresented: $addCourseShown) {
                        AddCourseView()
                    }
                    .popover(isPresented: $addProfileShown) {
                        AddProfileView()
                    }
                    .popover(isPresented: $addLessonShown) {
                        AddRoutineView(type: .lesson)
                    }
                    .popover(isPresented: $addChapterShown) {
                        AddChapterView()
                    }
                }
            }
            
    }
}

#Preview {
    NavigationStack {
        AddItemMenuWrapper(types: AddType.allCases) {
            Text("Hello Wrapper")
        }
        #if os(macOS)
        .frame(width: 500, height: 250)
        #endif
    }
}
