//
//  TodayView.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 16.01.25.
//

import SwiftUI

struct TodayView: View {
    var body: some View {
        List {
            CalendarWidget()
        }
        .navigationTitle("Today")
#if os(iOS)
        .navigationBarTitleDisplayMode(.automatic)
#endif
    }
}

#Preview {
    TodayView()
}
