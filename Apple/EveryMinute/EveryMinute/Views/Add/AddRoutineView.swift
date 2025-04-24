//
//  AddRoutineView.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 04.04.25.
//

import SwiftUI

internal struct AddRoutineView: View {
    
    @Environment(\.managedObjectContext) private var context
    
    @State private var name : String = ""
    
    @State private var date : Date = Date.now
    
    @State private var notes : String = ""
    
    @State private var interval : Int32 = 0
    
    @State private var errStoringShown : Bool = false
    
    var body: some View {
        AddItemSheetWrapper {
            do {
                let r = Routine(context: context)
                r.name = name
                r.date = date
                r.notes = notes
                r.interval = interval
                try context.save()
            } catch {
                errStoringShown.toggle()
            }
        } content: {
            List {
                Section {
                    TextField("Name", text: $name)
                    TextField("Notes", text: $notes)
                } header: {
                    Text("Information")
                } footer: {
                    Text("Specify the Routine")
                }
                Section {
                    DatePicker("Date", selection: $date)
                } header: {
                    Text("Date")
                } footer: {
                    Text("Specify first and following dates")
                }
            }
            #if os(macOS)
            .frame(width: 400, height: 200)
            #endif
            .navigationTitle("Add Routine")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.automatic)
            #endif
        }
        .alert("Error storing Routine", isPresented: $errStoringShown) {
        } message: {
            Text("There has been an error trying to store the routine")
        }
    }
}

#Preview {
    AddRoutineView()
}
