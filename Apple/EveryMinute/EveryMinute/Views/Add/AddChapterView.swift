//
//  AddChapterView.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 26.04.25.
//

import SwiftUI

internal struct AddChapterView: View {
    
    @Environment(\.managedObjectContext) private var context
    
    @State private var name : String = ""
    
    @State private var notes : String = ""
    
    @State private var date : Date = Date.now
    
    @State private var endDate : Date = Calendar.current.date(
        byAdding: .month,
        value: 1,
        to: Date.now
    )!
    
    @State private var color : Color = Color.green
    
    @State private var errSavingShown : Bool = false
    
    var body: some View {
        AddItemSheetWrapper {
            do {
                let chapter = Chapter(context: context)
                chapter.name = name
                chapter.date = date
                chapter.endDate = endDate
                chapter.notes = notes
                var red : CGFloat = 1
                var green : CGFloat = 1
                var blue : CGFloat = 1
#if os(iOS)
                UIColor(color).getRed(&red, green: &green, blue: &blue, alpha: nil)
#elseif os(macOS)
                NSColor(color).getRed(&red, green: &green, blue: &blue, alpha: nil)
#endif
                chapter.color = [
                    "red": red,
                    "green": green,
                    "blue": blue
                ]
                try context.save()
            } catch {
                errSavingShown.toggle()
            }
        } content: {
            List {
                Section {
                    TextField("Name", text: $name)
                    TextField("Notes", text: $notes, axis: .vertical)
                        .lineLimit(2...10)
                    ColorPicker("Color", selection: $color, supportsOpacity: false)
                } header: {
                    Text("General")
                } footer: {
                    Text("General information to identify the chapter")
                }
                Section {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    DatePicker(
                        "End Date",
                        selection: $endDate,
                        displayedComponents: .date
                    )
                } header: {
                    Text("Date")
                } footer: {
                    Text("Specify the timeframe of this new chapter")
                }
            }
            .alert("Error saving Chapter", isPresented: $errSavingShown) {
                
            } message: {
                Text("An error while trying to save the chapter occured.")
            }
            .navigationTitle("New Chapter")
#if os(iOS)
            .navigationBarTitleDisplayMode(.automatic)
#endif
        }
    }
}

#Preview {
    AddChapterView()
}
