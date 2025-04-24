//
//  SecuritySettingsView.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 21.03.25.
//

import SwiftUI

struct SecuritySettingsView: View {
    
    @State private var eraseDataWarningShown : Bool = false
    
    @State private var errEreasingDataShown : Bool = false
    
    var body: some View {
        List {
            Section {
                HStack {
                    Spacer()
                    Button(role: .destructive) {
                        eraseDataWarningShown = true
                    } label: {
                        Label("Erase Data", systemImage: "trash")
                            .foregroundStyle(.red)
                    }
                    Spacer()
                }
                .padding(.all, 8)
            } header: {
                Text("Data security")
            } footer: {
                Text("Keep control over your data")
            }
        }
        .alert("Erase all Data?", isPresented: $eraseDataWarningShown) {
            Button("Erase", role: .destructive) {
                guard eraseAllData() else {
                    errEreasingDataShown = true
                    return
                }
            }
        } message: {
            Text("Do you want to erase all data? This action is irreversible")
        }
        .alert("Error ereasing data", isPresented: $errEreasingDataShown) {
            Button("Try again", role: .destructive) {
                errEreasingDataShown = false
                guard eraseAllData() else {
                    errEreasingDataShown = true
                    return
                }
            }
        } message: {
            Text("Something went wrong while trying to erase all your data. Please try again to make sure your data are deleted. If this error persists, please contact support.")
        }
    }
    
    /// erases all data and returns a bool indicating the success of the operation
    private func eraseAllData() -> Bool {
        // TODO: implement
        return false
    }
}

#Preview {
    SecuritySettingsView()
}
