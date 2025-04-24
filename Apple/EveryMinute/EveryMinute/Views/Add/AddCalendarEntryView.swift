//
//  AddCalendarEntryView.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 04.04.25.
//

import SwiftUI
import MapKit

internal struct AddCalendarEntryView: View {
    
    @Environment(\.managedObjectContext) private var context
    
    @State private var name : String = ""
    
    @State private var date : Date = Date.now
    
    @State private var duration : Int32 = 60
    
    @State private var interval : Int32 = 0
    
    @State private var country : String = ""
    
    @State private var zip : String = ""
    
    @State private var address : String = ""
    
    @State private var notes : String = ""
    
    @State private var profiles : [Profile] = []
    
    @State private var profile : String = "No profile provided"
    
    @State private var errLoadingProfilesShown : Bool = false
    
    var body: some View {
        AddItemSheetWrapper {
            do {
                let c = CalendarEntry(context: context)
                c.name = name
                c.date = date
                c.duration = duration
                c.interval = interval
                c.location = ["country": country, "zipCode": zip, "address": address]
                c.notes = notes
                c.profile = profiles.first(where: { $0.name == profile })
                try context.save()
            } catch {
                
            }
        } content: {
            List {
                Section {
                    TextField("Name", text: $name)
                    TextField("Notes", text: $notes)
                    Picker("Profile", selection: $profile) {
                        ForEach(profiles, id: \.name) {
                            profile in
                            Text(profile.name!)
                        }
                    }
                    .pickerStyle(.automatic)
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
                Section {
                    TextField("Adress", text: $address)
                    TextField("ZIP", text: $zip)
                    TextField("Country", text: $country)
                    NavigationLink {
                        Map {
                            Marker(address, coordinate: CLLocationCoordinate2D())
                        }
                    } label: {
                        Label("View on Map", systemImage: "map")
                            .foregroundStyle(.primary)
                    }
                } header: {
                    Text("Adress")
                } footer: {
                    Text("The location of your event")
                }
            }
            .onAppear {
                do {
                    profiles = try Storage.loadProfiles(context)
                } catch {
                    errLoadingProfilesShown.toggle()
                }
            }
            .alert(
                "Error loading Profiles",
                isPresented: $errLoadingProfilesShown
            ) {
                
            }
            .navigationTitle("Add Calendar Entry")
#if os(macOS)
            .frame(width: 400, height: 200)
#endif
#if os(iOS)
            .navigationBarTitleDisplayMode(.automatic)
#endif
        }
    }
}

#Preview {
    AddCalendarEntryView()
}
