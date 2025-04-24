//
//  AddItemSheetWrapper.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 04.04.25.
//

import SwiftUI

/// A Wrapper to provide all sheets which add new objects to the app with a base structure.
/// Dismiss must not be called in the done function, the view will handle it after completing the done function
internal struct AddItemSheetWrapper<Content>: View where Content : View {
    
    @Environment(\.dismiss) private var dismiss
    
    /// The actual content of the view wrapper
    let content : () -> Content
    
    /// called when "done" has been pressed in the toolbar
    let done : () -> ()
    
    internal init(
        @ViewBuilder content : @escaping () -> Content,
        done : @escaping () -> ()
    ) {
        self.content = content
        self.done = done
    }
    
    internal init(
        done : @escaping () -> (),
        @ViewBuilder content : @escaping () -> Content
    ) {
        self.done = done
        self.content = content
    }
    
    var body: some View {
        NavigationStack {
            content()
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel", role: .cancel) {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            done()
                            dismiss()
                        }
                    }
                }
        }
    }
}

#Preview {
    AddItemSheetWrapper {
        Text("Hello Wrapper")
    } done: {
        print("Done pressed")
    }
}
