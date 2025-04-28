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
    
    @State private var entries : [CalendarEntry] = []
    
    @State private var errLoadingEntriesShown : Bool = false
    
    var body: some View {
        GeometryReader {
            metrics in
            ZStack {
                VStack {
                    ForEach(0..<5) {
                        _ in
                        Divider()
                            .padding(.vertical, metrics.size.height / 50)
                    }
                }
                VStack(spacing: 12) {
                    ForEach(entries) {
                        entry in
                        event(for: entry)
                    }
                }
            }
        }
        .onAppear {
            do {
                entries = try Storage.loadCalendarEntries(context,
                                                          from: Date.now,
                                                          count: 2)
            } catch {
                errLoadingEntriesShown.toggle()
            }
        }
    }
    
    @ViewBuilder
    private func event(for entry : CalendarEntry) -> some View {
        Text(entry.name!)
            .padding(.top, 10)
            .padding(.bottom, 35)
            .padding(.leading, 20)
            .padding(.trailing, 275)
#if os(iOS)
            .background(
                Color(
                    UIColor(
                        // Questions marks because profile is optional, the color composite type too, and the case to CGFloat should only happen, when the color value in non nil. After the double question mark is the default value for this attribute
                        red: entry.profile?.color?["red"] as? CGFloat ?? 0.76,
                        green: entry.profile?.color?["green"] as? CGFloat ?? 0,
                        blue: entry.profile?.color?["blue"] as? CGFloat ?? 1,
                        alpha: 0.5
                    )
                )
            )
#elseif os(macOS)
            .background(
                Color(
                    NSColor(
                        // Questions marks because profile is optional, the color composite type too, and the case to CGFloat should only happen, when the color value in non nil. After the double question mark is the default value for this attribute
                        red: entry.profile?.color?["red"] as? CGFloat ?? 0.76,
                        green: entry.profile?.color?["green"] as? CGFloat ?? 0,
                        blue: entry.profile?.color?["blue"] as? CGFloat ?? 1,
                        alpha: 0.5
                    )
                )
            )
#endif
            .containerShape(RoundedRectangle(cornerRadius: 25))
    }
}

#Preview {
    NavigationStack {
        CalendarWidget()
            .environment(\.managedObjectContext,
                          PersistenceController.preview.container.viewContext)
    }
}
