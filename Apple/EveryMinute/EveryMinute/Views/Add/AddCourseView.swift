//
//  AddCourseView.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 26.04.25.
//

import SwiftUI
import CoreData

internal struct AddCourseView: View {
    
    @Environment(\.managedObjectContext) private var context
    
    @State private var name : String = ""
    
    @State private var eval : String = ""
    
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.name)]
    ) private var chapters : FetchedResults<Chapter>
    
    @State private var selectedChapter : Chapter?
    
    @State private var errSavingChapterShown : Bool = false
    
    var body: some View {
        AddItemSheetWrapper(doneDisabled: .constant(false)) {
            do {
                let course = Course(context: context)
                course.name = name
                course.evaluation = Int16(eval) ?? 0
                if course.chapters == nil {
                    course.chapters = []
                }
                course.chapters?.adding(selectedChapter!)
                try context.save()
            } catch {
                EveryMinuteApp.logger.log(
                        level: .error, "Error saving new course: [\(error)]"
                )
                errSavingChapterShown.toggle()
            }
        } content: {
            List {
                TextField("Name", text: $name)
                TextField("Evaluation (in %)", text: $eval)
                    .keyboardType(.numbersAndPunctuation)
                Picker("Chapter", selection: $selectedChapter) {
                    Text("No chapter").tag(nil as Chapter?)
                    ForEach(chapters) {
                        chapter in
                        Text(chapter.name!).tag(chapter as Chapter?)
                    }
                }
            }
            .alert("Error saving", isPresented: $errSavingChapterShown) {
                
            } message: {
                Text("An error appeared while trying to save the coure")
            }
        }
    }
}

#Preview {
    AddCourseView()
}
