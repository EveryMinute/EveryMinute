//
//  ViewWrapper.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 29.03.25.
//

import SwiftUI

/// This wrapper enables the app to dynamically build the sidebar with it's navigation links
/// based on an array of control data
internal struct ViewWrapper: View {
    
    internal let types : [AddType]
    
    internal var view : StatusBarItemView
    
    var body: some View {
        AddItemMenuWrapper(types: types) {
            switch view {
            case .today:
                TodayView()
            case .home:
                HomeView()
            case .calendar:
                CalendarView()
            case .tasks:
                TasksView()
            }
        }
    }
}

#Preview {
    ViewWrapper(types: AddType.allCases, view: .today)
}
