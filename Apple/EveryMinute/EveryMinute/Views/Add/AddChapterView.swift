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
    
    var body: some View {
        AddItemSheetWrapper {
            do {
                let chapter = Chapter(context: context)
                chapter.name = name
                try context.save()
            } catch {
                // TODO: implement error handling
            }
        } content: {
            TextField("Name", text: $name)
        }
    }
}

#Preview {
    AddChapterView()
}
