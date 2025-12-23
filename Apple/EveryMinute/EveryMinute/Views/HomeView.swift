//
//  HomeView.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 16.01.25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
#if os(iOS)
                CalendarView()
                TimetableView()
#endif
            }
            .navigationTitle("Home")
        }
#if os(iOS)
        .navigationBarTitleDisplayMode(.automatic)
#endif
    }
}

#Preview {
    HomeView()
}
