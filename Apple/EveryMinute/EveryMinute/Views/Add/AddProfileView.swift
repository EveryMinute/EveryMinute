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
                // Werte sind normiert zwischen 0 und 1
                var red : CGFloat = 1
                var green : CGFloat = 1
                var blue : CGFloat = 1
#if os(iOS)
                UIColor(color).getRed(&red, green: &green, blue: &blue, alpha: nil)
#endif
#if os(macOS)
                NSColor(color).getRed(&red, green: &green, blue: &blue, alpha: nil)
#endif
                p.color = [
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
                    ColorPicker("Color", selection: $color, supportsOpacity: false)
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
