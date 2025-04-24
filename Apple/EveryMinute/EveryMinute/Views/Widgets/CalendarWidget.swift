//
//  CalendarWidget.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 21.04.25.
//

import SwiftUI
import CoreData

internal struct CalendarWidget: View {
    
    @Environment(\.managedObjectContext) var context
    
    internal var date : Date = Date.now
    
    @State private var entries : [CalendarEntry] = []
    
    @State private var errLoadingEntriesShown : Bool = false
    
    var body: some View {
        VStack {
            ForEach(entries) {
                entry in
                event(for: entry)
            }
        }
        .onAppear {
            do {
                entries = try Storage.loadCalendarEntries(context)
            } catch {
                errLoadingEntriesShown.toggle()
            }
        }
    }
    
    @ViewBuilder
    private func event(for entry : CalendarEntry) -> some View {
        Text(entry.name!)
            .padding(.top, 12.5)
            .padding(.bottom, 75)
            .padding(.leading, 12.5)
            .padding(.trailing, 250)
            .background(
                Color(
                    UIColor(
                        // Questions marks because profile is optional, the color composite type too, and the case to CGFloat should only happen, when the color value in non nil. After the double question mark is the default value for this attribute
                        red: entry.profile?.color?["red"] as? CGFloat ?? 255,
                        green: entry.profile?.color?["green"] as? CGFloat ?? 255,
                        blue: entry.profile?.color?["blue"] as? CGFloat ?? 255,
                        alpha: entry.profile?.color?["alpha"] as? CGFloat ?? 1
                    )
                )
            )
            .containerShape(RoundedRectangle(cornerRadius: 25))
    }
}

#Preview {
    NavigationStack {
        CalendarWidget(date: Date.now)
    }
}
