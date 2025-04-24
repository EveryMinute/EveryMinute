//
//  AddProfileView.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 22.04.25.
//

import SwiftUI

internal struct AddProfileView: View {
    
    @Environment(\.managedObjectContext) private var context
    
    @State private var name : String = ""
    
    @State private var color : Color = Color.blue
    
    @State private var errSavingShown : Bool = false
    
    var body: some View {
        AddItemSheetWrapper {
            do {
                let p  = Profile(context: context)
                p.name = name
                p.color = ["red": 1, "green": 1, "blue": 1]
                try context.save()
            } catch {
                errSavingShown.toggle()
            }
        } content: {
            List {
                Section {
                    TextField("Name", text: $name)
                    ColorPicker("Color", selection: $color, supportsOpacity: true)
                } header: {
                    Text("Information")
                } footer: {
                    Text("Create a new profile to categorize your data")
                }
            }
        }
        .navigationTitle("Add Profile")
#if os(iOS)
        .navigationBarTitleDisplayMode(.automatic)
#endif
        .alert("Error saving", isPresented: $errSavingShown) {
            
        } message: {
            Text("There's been an error while trying to safe the profile")
        }
    }
}

#Preview {
    AddProfileView()
}
